import QtQuick 2.15
import RingUI
import example

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
