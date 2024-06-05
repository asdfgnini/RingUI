import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T
import RingUI

T.ToolTip {
    id: control
    //implicitWidth为控件的隐式宽度，控件的宽度可以根据内容自适应变化
    //width是显示指定控件的宽度，控件的宽度固定不变，同时width的优先级要高于implicitWidth
    x: parent ? (parent.width - implicitWidth) / 2 : 0
    y: -implicitHeight - 3
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)
    margins: 6
    padding: 6
    font: RingTextStyle.Body
    closePolicy: T.Popup.CloseOnEscape | T.Popup.CloseOnPressOutsideParent | T.Popup.CloseOnReleaseOutsideParent
    contentItem: RingText {
        text: control.text
        font: control.font
        wrapMode: Text.Wrap
    }
    background: Rectangle {
        color: RingTheme.dark ? Qt.rgba(50/255,49/255,48/255,1) : Qt.rgba(1,1,1,1)
        radius: 3
        RingShadow{
            radius: 3
        }
    }
}
