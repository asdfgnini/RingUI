import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import RingUI 1.0


RingScrollablePage
{

    title: qsTr("Buttons")

    RingText{
        text: qsTr("Support the Tab key to switch focus, and the Space key to perform click events")
    }

    RingFrame{
        Layout.fillWidth: true
        Layout.preferredHeight: 68
        Layout.topMargin: 10
        padding: 10

        RingTextButton{
            disabled: text_button_switch.checked
            text:qsTr("Text Button")
            onClicked:{
                showInfo("点击Text Button")
            }
        }

        RingToggleSwitch{
            id:text_button_switch
            anchors{
                right: parent.right
                verticalCenter: parent.verticalCenter
            }
            text:qsTr("Disable")
        }

    }






}
