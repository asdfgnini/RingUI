import QtQuick
import QtQuick.Controls
import RingTheme 1.0

Text {
    property color textColor: RingTheme.fontPrimaryColor
    id:text
    color: textColor
    renderType: RingTheme.nativeText ? Text.NativeRendering : Text.QtRendering
    font: RingTextStyle.Body
}
