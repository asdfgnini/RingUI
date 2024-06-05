pragma Singleton

import QtQuick 2.15
import RingUI 1.0

RingObject{
    property var navigationView
    property var paneItemMenu
    id:footer_items
    RingPaneItemSeparator{}

    RingPaneItem{
        title:qsTr("About")
        icon:RingIcons.Contact
        onTapListener:function(){
            RingRouter.navigate("/about")
        }
    }
    RingPaneItem{
        title:qsTr("Settings")
        menuDelegate: paneItemMenu
        icon:RingIcons.Settings
        url:"qrc:/example/qml/page/T_Settings.qml"
        onTap:{
            navigationView.push(url)
        }
    }
}
