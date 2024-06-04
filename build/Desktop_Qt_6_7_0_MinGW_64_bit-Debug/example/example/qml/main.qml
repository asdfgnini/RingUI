import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import RingUI


RingWindow {
    id:window
    title:"Standard"
    width: 500
    height: 600
    fixSize: true
    launchMode: RingWindowType.Standard

    RingMenuBar {
        RingMenu {
            title: qsTr("File")
            Action { text: qsTr("New...") }
            Action { text: qsTr("Open...") }
            Action { text: qsTr("Save") }
            Action { text: qsTr("Save As...") }
            RingMenuSeparator { }
            Action { text: qsTr("Quit") }
        }
        RingMenu {
            title: qsTr("Edit")
            Action { text: qsTr("Cut") }
            Action { text: qsTr("Copy") }
            Action { text: qsTr("Paste") }
        }
        RingMenu {
            title: qsTr("Help")
            Action { text: qsTr("About") }
        }
    }

    RingText{
        anchors.centerIn: parent
        text: qsTr("I'm a Standard mode window, and every time I create a new window")
    }

}
