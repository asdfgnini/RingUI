import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import RingUI

Rectangle{
    property string title: ""
    property string darkText : qsTr("Dark")
    property string lightText : qsTr("Light")
    property string minimizeText : qsTr("Minimize")
    property string restoreText : qsTr("Restore")
    property string maximizeText : qsTr("Maximize")
    property string closeText : qsTr("Close")
    property string stayTopText : qsTr("Sticky on Top")
    property string stayTopCancelText : qsTr("Sticky on Top cancelled")
    property color textColor: RingTheme.fontPrimaryColor
    property color minimizeNormalColor: RingTheme.itemNormalColor
    property color minimizeHoverColor: RingTheme.itemHoverColor
    property color minimizePressColor: RingTheme.itemPressColor
    property color maximizeNormalColor: RingTheme.itemNormalColor
    property color maximizeHoverColor: RingTheme.itemHoverColor
    property color maximizePressColor: RingTheme.itemPressColor
    property color closeNormalColor: Qt.rgba(0,0,0,0)
    property color closeHoverColor: Qt.rgba(251/255,115/255,115/255,1)
    property color closePressColor: Qt.rgba(251/255,115/255,115/255,0.8)
    property bool showDark: false
    property bool showClose: true
    property bool showMinimize: true
    property bool showMaximize: true
    property bool showStayTop: true
    property bool titleVisible: true
    property url icon
    property int iconSize: 20
    property color borerlessColor : RingTheme.primaryColor
    property alias buttonStayTop: btn_stay_top
    property alias buttonMinimize: btn_minimize
    property alias buttonMaximize: btn_maximize
    property alias buttonClose: btn_close
    property alias buttonDark: btn_dark
    property alias layoutStandardbuttons: layout_standard_buttons
    property var maxClickListener : function(){
        if (d.win.visibility === Window.Maximized)
            d.win.showNormal()
        else
            d.win.showMaximized()
        d.hoverMaxBtn = false

    }
    property var minClickListener: function(){
        if(d.win.transientParent !== null){
            d.win.transientParent.showMinimized()
        }else{
            d.win.showMinimized()
        }
    }
    property var closeClickListener : function(){
        d.win.close()
    }
    property var stayTopClickListener: function(){
        if(d.win instanceof RingWindow){
            d.win.stayTop = !d.win.stayTop
        }
    }
    property var darkClickListener: function(){
        if(RingTheme.dark){
            RingTheme.darkMode = RingThemeType.Light
        }else{
            RingTheme.darkMode = RingThemeType.Dark
        }
    }
    id:control
    color: Qt.rgba(0,0,0,0)
    height: visible ? 30 : 0
    opacity: visible
    z: 65535
    Item{
        id:d
        property var hitTestList: []
        property bool hoverMaxBtn: false
        property var win: Window.window
        property bool stayTop: {
            if(d.win instanceof RingWindow){
                return d.win.stayTop
            }
            return false
        }
        property bool isRestore: win && Window.Maximized === win.visibility
        property bool resizable: win && !(win.height === win.maximumHeight && win.height === win.minimumHeight && win.width === win.maximumWidth && win.width === win.minimumWidth)
        function containsPointToItem(point,item){
            var pos = item.mapToGlobal(0,0)
            var rect = Qt.rect(pos.x,pos.y,item.width,item.height)
            if(point.x>rect.x && point.x<(rect.x+rect.width) && point.y>rect.y && point.y<(rect.y+rect.height)){
                return true
            }
            return false
        }
    }
    Row{
        anchors{
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 10
            horizontalCenter: undefined
        }
        spacing: 10
        Image{
            width: control.iconSize
            height: control.iconSize
            visible: status === Image.Ready ? true : false
            source: control.icon
            anchors.verticalCenter: parent.verticalCenter
        }
        RingText {
            text: title
            visible: control.titleVisible
            color:control.textColor
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    RowLayout{
        id:layout_standard_buttons
        height: parent.height
        anchors.right: parent.right
        spacing: 0
        RingIconButton{
            id:btn_dark
            Layout.preferredWidth: 40
            Layout.preferredHeight: 30
            padding: 0
            verticalPadding: 0
            horizontalPadding: 0
            rightPadding: 2
            iconSource: RingTheme.dark ? RingIcons.Brightness : RingIcons.QuietHours
            Layout.alignment: Qt.AlignVCenter
            iconSize: 15
            visible: !showDark
            text: RingTheme.dark ? control.lightText : control.darkText
            radius: 0
            iconColor:control.textColor
            onClicked:()=> darkClickListener(btn_dark)
        }
        RingIconButton{
            id:btn_stay_top
            Layout.preferredWidth: 40
            Layout.preferredHeight: 30
            padding: 0
            verticalPadding: 0
            horizontalPadding: 0
            iconSource : RingIcons.Pinned
            Layout.alignment: Qt.AlignVCenter
            iconSize: 14
            visible: {
                if(!(d.win instanceof RingWindow)){
                    return false
                }
                return showStayTop
            }
            text:d.stayTop ? control.stayTopCancelText : control.stayTopText
            radius: 0
            iconColor: d.stayTop ? RingTheme.primaryColor : control.textColor
            onClicked: stayTopClickListener()
        }
        RingIconButton{
            id:btn_minimize
            Layout.preferredWidth: 40
            Layout.preferredHeight: 30
            padding: 0
            verticalPadding: 0
            horizontalPadding: 0
            iconSource : RingIcons.ChromeMinimize
            Layout.alignment: Qt.AlignVCenter
            iconSize: 11
            text:minimizeText
            radius: 0
            visible: showMinimize
            iconColor: control.textColor
            color: {
                if(pressed){
                    return minimizePressColor
                }
                return hovered ? minimizeHoverColor : minimizeNormalColor
            }
            onClicked: minClickListener()
        }
        RingIconButton{
            id:btn_maximize
            property bool hover: btn_maximize.hovered
            Layout.preferredWidth: 40
            Layout.preferredHeight: 30
            padding: 0
            verticalPadding: 0
            horizontalPadding: 0
            iconSource : d.isRestore  ? RingIcons.ChromeRestore : RingIcons.ChromeMaximize
            color: {
                if(down){
                    return maximizePressColor
                }
                return btn_maximize.hover ? maximizeHoverColor : maximizeNormalColor
            }
            Layout.alignment: Qt.AlignVCenter
            visible: d.resizable && showMaximize
            radius: 0
            iconColor: control.textColor
            text:d.isRestore?restoreText:maximizeText
            iconSize: 11
            onClicked: maxClickListener()
        }
        RingIconButton{
            id:btn_close
            Layout.preferredWidth: 40
            Layout.preferredHeight: 30
            padding: 0
            verticalPadding: 0
            horizontalPadding: 0
            iconSource : RingIcons.ChromeClose
            Layout.alignment: Qt.AlignVCenter
            text:closeText
            visible: showClose
            radius: 0
            iconSize: 10
            iconColor: hovered ? Qt.rgba(1,1,1,1) : control.textColor
            color:{
                if(pressed){
                    return closePressColor
                }
                return hovered ? closeHoverColor : closeNormalColor
            }
            onClicked: closeClickListener()
        }
    }
}
