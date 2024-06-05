import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts
import RingUI

Button {
    property bool disabled: false
    property string contentDescription: ""
    property color disableColor: RingTheme.dark ? Qt.rgba(82/255,82/255,82/255,1) : Qt.rgba(233/255,233/255,233/255,1)
    property color checkColor: RingTheme.primaryColor
    property color hoverColor: RingTheme.dark ? Qt.rgba(62/255,62/255,62/255,1) : Qt.rgba(240/255,240/255,240/255,1)
    property color normalColor: RingTheme.dark ? Qt.rgba(50/255,50/255,50/255,1) : Qt.rgba(253/255,253/255,253/255,1)
    property color borderNormalColor: RingTheme.dark ? Qt.rgba(161/255,161/255,161/255,1) : Qt.rgba(141/255,141/255,141/255,1)
    property color borderCheckColor: RingTheme.primaryColor
    property color borderDisableColor: RingTheme.dark ? Qt.rgba(50/255,50/255,50/255,1) : Qt.rgba(200/255,200/255,200/255,1)
    property color dotNormalColor: RingTheme.dark ? Qt.rgba(208/255,208/255,208/255,1) : Qt.rgba(93/255,93/255,93/255,1)
    property color dotCheckColor: RingTheme.dark ? Qt.rgba(0/255,0/255,0/255,1) : Qt.rgba(255/255,255/255,255/255,1)
    property color dotDisableColor: RingTheme.dark ? Qt.rgba(50/255,50/255,50/255,1) : Qt.rgba(150/255,150/255,150/255,1)
    property real textSpacing: 6
    property bool textRight: true
    property alias textColor: btn_text.textColor
    property var clickListener : function(){
        checked = !checked
    }
    id: control
    Accessible.role: Accessible.Button
    Accessible.name: control.text
    Accessible.description: contentDescription
    Accessible.onPressAction: control.clicked()
    enabled: !disabled
    focusPolicy:Qt.TabFocus
    onClicked: clickListener()
    padding: 0
    horizontalPadding: 0
    onCheckableChanged: {
        if(checkable){
            checkable = false
        }
    }
    background : Item{
        implicitHeight: 20
        implicitWidth: 40
    }
    contentItem: RowLayout{
        spacing: control.textSpacing
        layoutDirection:control.textRight ? Qt.LeftToRight : Qt.RightToLeft
        Rectangle {
            id:control_backgound
            implicitWidth: background.implicitWidth
            implicitHeight: background.implicitHeight
            radius: height / 2
            RingFocusRectangle{
                visible: control.activeFocus
                radius: parent.radius
            }
            color: {
                if(!enabled){
                    return disableColor
                }
                if(checked){
                    return checkColor
                }
                if(hovered){
                    return hoverColor
                }
                return normalColor
            }
            border.width: 1
            border.color: {
                if(!enabled){
                    return borderDisableColor
                }
                if(checked){
                    return borderCheckColor
                }
                return borderNormalColor
            }
            RingIcon {
                width:  parent.height
                x:checked ? control_backgound.width-width : 0
                scale: {
                    if(pressed){
                        return 5/10
                    }
                    return hovered&enabled ? 7/10 : 6/10
                }
                iconSource: RingIcons.FullCircleMask
                iconSize: 20
                color: {
                    if(!enabled){
                        return dotDisableColor
                    }
                    if(checked){
                        return dotCheckColor
                    }
                    return dotNormalColor
                }
                Behavior on scale{
                    NumberAnimation{
                        duration: 167
                        easing.type: Easing.OutCubic
                    }
                }
                Behavior on x  {
                    enabled: RingTheme.animationEnabled
                    NumberAnimation {
                        duration: 167
                        easing.type: Easing.OutCubic
                    }
                }
            }
        }
        RingText{
            id:btn_text
            text: control.text
            Layout.alignment: Qt.AlignVCenter
            visible: text !== ""
        }
    }
}
