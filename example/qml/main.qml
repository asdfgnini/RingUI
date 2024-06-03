import QtQuick
import RingUI

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    RingButton{
        text:"cliked"
        contentDescription: ""
        disabled: false
        onClicked: {
            console.log("OKK")
        }
    }

}
