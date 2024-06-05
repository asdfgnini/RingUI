import QtQuick
import QtQuick.Controls
import RingUI

QtObject {
    property string key
    property int _idx
    property bool visible: true
    property string title
    property var parent
    Component.onCompleted: {
        key = RingTools.uuid()
    }
}
