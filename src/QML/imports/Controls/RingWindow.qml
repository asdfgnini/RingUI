import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import RingUI

Window {
    default property alias contentData : layout_content.data
    property string windowIcon: RingApp.windowIcon
    property int launchMode: RingWindowType.Standard
    property var argument:({})
    property var background : com_background
    property bool fixSize: false
    property Component loadingItem: com_loading
    property bool fitsAppBarWindows: false
    property Item appBar: RingAppBar {
        title: window.title
        height: 30
        width: window.width
        showDark: window.showDark
        showClose: window.showClose
        showMinimize: window.showMinimize
        showMaximize: window.showMaximize
        showStayTop: window.showStayTop
        icon: window.windowIcon
    }
    property color backgroundColor: {
        if(active){
            return RingTheme.windowActiveBackgroundColor
        }
        return RingTheme.windowBackgroundColor
    }
    property bool stayTop: false
    property bool showDark: false
    property bool showClose: true
    property bool showMinimize: true
    property bool showMaximize: true
    property bool showStayTop: false
    property bool autoMaximize: false
    property bool autoVisible: true
    property bool autoCenter: true
    property bool autoDestroy: true
    property bool useSystemAppBar
    property color resizeBorderColor: {
        if(window.active){
            return RingTheme.dark ? Qt.rgba(51/255,51/255,51/255,1) : Qt.rgba(110/255,110/255,110/255,1)
        }
        return RingTheme.dark ? Qt.rgba(61/255,61/255,61/255,1) : Qt.rgba(167/255,167/255,167/255,1)
    }
    property int resizeBorderWidth: 1
    property var closeListener: function(event){
        if(autoDestroy){
            RingRouter.removeWindow(window)
        }else{
            window.visibility = Window.Hidden
            event.accepted = false
        }
    }
    signal initArgument(var argument)
    signal lazyLoad()
    property var _windowRegister
    property string _route
    id:window
    color:"transparent"
    Component.onCompleted: {
        RingRouter.addWindow(window)
        useSystemAppBar = RingApp.useSystemAppBar
        if(!useSystemAppBar && autoCenter){
            moveWindowToDesktopCenter()
        }
        fixWindowSize()
        initArgument(argument)
        if(window.autoVisible){
            if(window.autoMaximize){
                window.showMaximized()
            }else{
                window.show()
            }
        }
    }
    onVisibleChanged: {
        if(visible && d.isLazyInit){
            window.lazyLoad()
            d.isLazyInit = false
        }
    }
    QtObject{
        id:d
        property bool isLazyInit: true
    }
    Connections{
        target: window
        function onClosing(event){closeListener(event)}
    }

    //为当前window添加无边框属性
    RingFrameless{
        id: frameless
        appbar: window.appBar
        maximizeButton: appBar.buttonMaximize
        fixSize: window.fixSize
        topmost: window.stayTop
        disabled: RingApp.useSystemAppBar
        Component.onCompleted: {
            frameless.setHitTestVisible(appBar.layoutStandardbuttons)
        }
        Component.onDestruction: {
            frameless.onDestruction()
        }
    }
    Component{
        id:com_background
        Item{
            Rectangle{
                anchors.fill: parent
                color: window.backgroundColor
            }
            Image{
                id:img_back
                visible: false
                cache: false
                fillMode: Image.PreserveAspectCrop
                asynchronous: true
                Component.onCompleted: {
                    var geometry = RingTools.desktopAvailableGeometry(window)
                    width = geometry.width
                    height =  geometry.height
                    sourceSize = Qt.size(width,height)
                    source = RingTools.getUrlByFilePath(RingTheme.desktopImagePath)
                }
                Connections{
                    target: RingTheme
                    function onDesktopImagePathChanged(){
                        timer_update_image.restart()
                    }
                    function onBlurBehindWindowEnabledChanged(){
                        if(RingTheme.blurBehindWindowEnabled){
                            img_back.source = RingTools.getUrlByFilePath(RingTheme.desktopImagePath)
                        }else{
                            img_back.source = ""
                        }
                    }
                }
                Timer{
                    id:timer_update_image
                    interval: 500
                    onTriggered: {
                        img_back.source = ""
                        img_back.source = RingTools.getUrlByFilePath(RingTheme.desktopImagePath)
                    }
                }
            }
            RingAcrylic{
                anchors.fill: parent
                target: img_back
                tintOpacity: RingTheme.dark ? 0.80 : 0.75
                blurRadius: 64
                visible: window.active && RingTheme.blurBehindWindowEnabled
                tintColor: RingTheme.dark ? Qt.rgba(0, 0, 0, 1)  : Qt.rgba(1, 1, 1, 1)
                targetRect: Qt.rect(window.x,window.y,window.width,window.height)
            }
        }
    }
    Component{
        id:com_app_bar
        Item{
            data: window.appBar
        }
    }
    Component{
        id:com_loading
        Popup{
            id:popup_loading
            focus: true
            width: window.width
            height: window.height
            anchors.centerIn: Overlay.overlay
            closePolicy: {
                if(cancel){
                    return Popup.CloseOnEscape | Popup.CloseOnPressOutside
                }
                return Popup.NoAutoClose
            }
            Overlay.modal: Item {}
            onVisibleChanged: {
                if(!visible){
                    loader_loading.sourceComponent = undefined
                }
            }
            padding: 0
            opacity: 0
            visible:true
            Behavior on opacity {
                SequentialAnimation {
                    PauseAnimation {
                        duration: 83
                    }
                    NumberAnimation{
                        duration:  167
                    }
                }
            }
            Component.onCompleted: {
                opacity = 1
            }
            background: Rectangle{
                color:"#44000000"
            }
            contentItem: Item{
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if (cancel){
                            popup_loading.visible = false
                        }
                    }
                }
                ColumnLayout{
                    spacing: 8
                    anchors.centerIn: parent
                    RingProgressRing{
                        Layout.alignment: Qt.AlignHCenter
                    }
                    RingText{
                        text:loadingText
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
            }
        }
    }
    Component{
        id:com_border
        Rectangle{
            color:"transparent"
            border.width: window.resizeBorderWidth
            border.color: window.resizeBorderColor
        }
    }


    RingLoader{
        anchors.fill: parent
        sourceComponent: background
    }
    RingLoader{
        id:loader_app_bar
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: {
            if(window.useSystemAppBar){
                return 0
            }
            return window.fitsAppBarWindows ? 0 : window.appBar.height
        }
        sourceComponent: window.useSystemAppBar ? undefined : com_app_bar
    }
    //app_bar和backbound的分割线
    Item{
        id:layout_content
        anchors{
            top: loader_app_bar.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        clip: true
    }
    RingLoader{
        property string loadingText
        property bool cancel: false
        id:loader_loading
        anchors.fill: parent
    }
    RingInfoBar{
        id:info_bar
        root: window
    }
    RingLoader{
        id:loader_border
        anchors.fill: parent
        sourceComponent: {
            if(window.useSystemAppBar || RingTools.isWin() || window.visibility === Window.Maximized || window.visibility === Window.FullScreen){
                return undefined
            }
            return com_border
        }
    }
    function hideLoading(){
        loader_loading.sourceComponent = undefined
    }
    function showSuccess(text,duration,moremsg){
        return info_bar.showSuccess(text,duration,moremsg)
    }
    function showInfo(text,duration,moremsg){
        return info_bar.showInfo(text,duration,moremsg)
    }
    function showWarning(text,duration,moremsg){
        return info_bar.showWarning(text,duration,moremsg)
    }
    function showError(text,duration,moremsg){
        return info_bar.showError(text,duration,moremsg)
    }
    function clearAllInfo(){
        return info_bar.clearAllInfo()
    }
    function moveWindowToDesktopCenter(){
        //获取当前鼠标所在屏幕
        screen = Qt.application.screens[RingTools.cursorScreenIndex()]
        //获取窗口所在屏幕的可用几何信息
        var availableGeometry = RingTools.desktopAvailableGeometry(window)
        //计算窗口居中位置并设置窗口几何信息
        window.setGeometry((availableGeometry.width-window.width)/2+Screen.virtualX,(availableGeometry.height-window.height)/2+Screen.virtualY,window.width,window.height)
    }
    function fixWindowSize(){
        if(fixSize){
            window.maximumWidth =  window.width
            window.maximumHeight =  window.height
            window.minimumWidth = window.width
            window.minimumHeight = window.height
        }
    }
    function registerForWindowResult(path){
        return RingApp.createWindowRegister(window,path)
    }
    function setResult(data){
        if(_windowRegister){
            _windowRegister.setResult(data)
        }
    }
    function showMaximized(){
        frameless.showMaximized()
    }
    function showMinimized(){
        frameless.showMinimized()
    }
    function showNormal(){
        frameless.showNormal()
    }
    function showLoading(text = "",cancel = true){
        if(text===""){
            text = qsTr("Loading...")
        }
        loader_loading.loadingText = text
        loader_loading.cancel = cancel
        loader_loading.sourceComponent = com_loading
    }
    function setHitTestVisible(val){
        frameless.setHitTestVisible(val)
    }
}
