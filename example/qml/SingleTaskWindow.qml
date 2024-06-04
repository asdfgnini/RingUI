import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import RingUI 1.0


RingWindow {

    id: window
    title: qsTr("SingleTask")
    width: 500
    height: 600
    fixSize: true
    launchMode: RingWindowType.SingleTask

    RingText{
        anchors.centerIn: parent
        text: qsTr("I'm a SingleTask mode window, and if I exist, I activate the window")
    }
}
