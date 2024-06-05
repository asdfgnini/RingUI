import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQml 2.15
import Qt.labs.platform 1.1
import RingUI
import example 1.0
import "../global"

RingWindow {

    id:window
    width: 1000
    height: 680
    minimumWidth: 680
    minimumHeight: 200
    launchMode: RingWindowType.SingleTask
    fitsAppBarWindows: true
    appBar: RingAppBar {
        width: window.width
        height: 30
        showDark: true
        darkClickListener:(button)=>handleDarkChanged(button)
        // closeClickListener: ()=>{dialog_close.open()}
        z:7
    }
    Component.onCompleted: {
        console.log("主页面启动")
    }

    Component.onDestruction: {
        RingRouter.exit()
    }

    //关闭窗口时的显示窗口
    RingContentDialog{
        id: dialog_close
        title: qsTr("Quit")
        message: qsTr("你好 Are you sure you want to exit the program?")
        negativeText: qsTr("Minimize")
        buttonFlags: RingContentDialogType.NegativeButton | RingContentDialogType.NeutralButton | RingContentDialogType.PositiveButton

        positiveText: qsTr("Quit")
        neutralText: qsTr("Cancel")
        onPositiveClicked:{
            RingRouter.exit(0)
        }
    }
    //打包页面组件，通过navigate动态创建窗口
    Component{
        id: nav_item_right_menu
        RingMenu{
            width: 186
            RingMenuItem{
                text: qsTr("Open in Separate Window")
                font: RingTextStyle.Caption
                onClicked: {
                    RingRouter.navigate("/pageWindow",{title:modelData.title,url:modelData.url})
                }
            }
        }
    }
    //定义一个可以翻转的控件
    Flipable{
        id:flipable
        anchors.fill: parent
        property bool flipped: false
        property real flipAngle: 0
        transform: Rotation {
            id: rotation
            origin.x: flipable.width/2
            origin.y: flipable.height/2
            axis { x: 0; y: 1; z: 0 }
            angle: flipable.flipAngle

        }
        states: State {
            PropertyChanges { target: flipable; flipAngle: 180 }
            when: flipable.flipped
        }
        transitions: Transition {
            NumberAnimation { target: flipable; property: "flipAngle"; duration: 1000 ; easing.type: Easing.OutCubic}
        }
        back: Item{
            anchors.fill: flipable
            visible: flipable.flipAngle !== 0
            Row{
                id:layout_back_buttons
                z:8
                anchors{
                    top: parent.top
                    left: parent.left
                    topMargin: RingTools.isMacos() ? 20 : 5
                    leftMargin: 5
                }
                RingIconButton{
                    iconSource: RingIcons.ChromeBack
                    width: 30
                    height: 30
                    iconSize: 13
                    onClicked: {
                        flipable.flipped = false
                    }
                }
                Component.onCompleted: {
                    window.setHitTestVisible(layout_back_buttons)
                }
            }
        }
        front: Item{
            id:page_front
            visible: flipable.flipAngle !== 180
            anchors.fill: flipable
            //模仿安卓的导航控件
            RingNavigationView{
                property int clickCount: 0
                id:nav_view
                width: parent.width
                height: parent.height
                z:999
                //Stack模式，每次切换都会将页面压入栈中，随着栈的页面增多，消耗的内存也越多，内存消耗多就会卡顿，这时候就需要按返回将页面pop掉，释放内存。该模式可以配合FluPage中的launchMode属性，设置页面的启动模式
                //                pageMode: FluNavigationViewType.Stack
                //NoStack模式，每次切换都会销毁之前的页面然后创建一个新的页面，只需消耗少量内存
                pageMode: RingNavigationViewType.NoStack
                items: ItemsOriginal
                topPadding:{
                    if(window.useSystemAppBar){
                        return 0
                    }
                    return RingTools.isMacos() ? 20 : 0
                }
                displayMode: GlobalModel.displayMode
                logo: "qrc:/example/res/image/ic_crash.png"
                title:"RingUI"
                onLogoClicked:{
                    clickCount += 1
                    showSuccess("%1:%2".arg(qsTr("Click Time")).arg(clickCount))
                    if(clickCount === 5){
                        flipable.flipped = true
                        clickCount = 0
                    }
                }
                Component.onCompleted: {
                    ItemsOriginal.navigationView = nav_view
                    ItemsOriginal.paneItemMenu = nav_item_right_menu
                    window.setHitTestVisible(nav_view.buttonMenu)
                    window.setHitTestVisible(nav_view.buttonBack)
                    window.setHitTestVisible(nav_view.imageLogo)
                    setCurrentIndex(0)
                }
            }
        }
    }
    //打包主题颜色切换组件
    Component{
        id: com_reveal
        CircularReveal{
            id: reveal
            target: window.contentItem
            anchors.fill: parent
            onAnimationFinished:{
                //动画结束后释放资源
                loader_reveal.sourceComponent = undefined
            }
            onImageChanged: {
                changeDark()
            }
        }
    }
    RingLoader{
        id:loader_reveal
        anchors.fill: parent
    }

    function distance(x1,y1,x2,y2){
        return Math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))
    }

    function handleDarkChanged(button){
        if(!RingTheme.animationEnabled || window.fitsAppBarWindows === false){
            changeDark()
        }else{
            if(loader_reveal.sourceComponent){
                return
            }
            loader_reveal.sourceComponent = com_reveal
            var target = window.contentItem
            var pos = button.mapToItem(target,0,0)
            var mouseX = pos.x
            var mouseY = pos.y
            var radius = Math.max(distance(mouseX,mouseY,0,0),distance(mouseX,mouseY,target.width,0),distance(mouseX,mouseY,0,target.height),distance(mouseX,mouseY,target.width,target.height))
            var reveal = loader_reveal.item
            reveal.start(reveal.width*Screen.devicePixelRatio,reveal.height*Screen.devicePixelRatio,Qt.point(mouseX,mouseY),radius)
        }
    }

    function changeDark(){
        if(RingTheme.dark){
            RingTheme.darkMode = RingThemeType.Light
        }else{
            RingTheme.darkMode = RingThemeType.Dark
        }
    }


}
