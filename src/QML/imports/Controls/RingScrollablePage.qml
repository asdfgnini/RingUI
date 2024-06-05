import QtQuick
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Controls
import RingUI

RingPage {
    default property alias content: container.data
    Flickable{
        clip: true
        anchors.fill: parent
        ScrollBar.vertical: RingScrollBar {}
        boundsBehavior: Flickable.StopAtBounds
        contentHeight: container.height
        ColumnLayout{
            id:container
            width: parent.width
        }
    }
}
