import QtQuick
import QtQuick.Controls
import RingUI

QtObject {
    id:control
    property string name
    signal triggered(var data)
    Component.onCompleted: {
        RingEventBus.register(control)
    }
    Component.onDestruction: {
        RingEventBus.unregister(control)
    }
}
