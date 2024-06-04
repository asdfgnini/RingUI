import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQml 2.15
import Qt.labs.platform 1.1
import RingUI
import example 1.0

RingWindow {

    id:window
    title: "RingUI"
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
        icon:"qrc:/example/res/image/favicon.ico"
        title: window.title
    }

    Component.onCompleted: {
        console.log("主页面启动")
    }

    Component.onDestruction: {
        router_main.exit()
    }




    RingContentDialog{
        id: dialog_close
        title: qsTr("Quit")
        message: qsTr("你好 Are you sure you want to exit the program?")
        negativeText: qsTr("Minimize")
        buttonFlags: RingContentDialogType.NegativeButton | RingContentDialogType.NeutralButton | RingContentDialogType.PositiveButton
        onNegativeClicked: {
            system_tray.showMessage(qsTr("Friendly Reminder"),qsTr("RingentUI is hidden from the tray, click on the tray to activate the window again"));
            timer_window_hide_delay.restart()
        }
        positiveText: qsTr("Quit")
        neutralText: qsTr("Cancel")
        onPositiveClicked:{
            router_main.exit(0)
        }
    }
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
    RingRouter
    {
        id:router_main
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
