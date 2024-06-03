import QtQuick
import QtQuick.Controls
import RingUI

Text {
    property color textColor: RingTheme.fontPrimaryColor
    id:text
    color: textColor
    renderType: RingTheme.nativeText ? Text.NativeRendering : Text.QtRendering
    font: RingTextStyle.Body
}
