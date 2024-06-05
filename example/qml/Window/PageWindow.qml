import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import RingUI 1.0
import example 1.0

RingWindow {
    id:window
    width: 800
    height: 600
    minimumWidth: 520
    minimumHeight: 200
    launchMode: FluWindowType.SingleInstance
    onInitArgument:
        (arg)=>{
            console.log("OKOKO123")
            window.title = arg.title
            loader.setSource(arg.url,{animationEnabled:false})
        }
    RingLoader{
        id: loader
        anchors.fill: parent
    }
}
