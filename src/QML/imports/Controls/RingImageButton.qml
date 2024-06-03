import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import RingUI

Button {
    id:control
    //定义正常时显示的图片
    property string normalImage: ""
    //定义悬停时显示的图片
    property string hoveredImage: ""
    //定义按压时显示的图片
    property string pushedImage: ""
    background: Item {
        implicitHeight: 12
        implicitWidth: 12
        BorderImage{
            anchors.fill: parent
            source: control.hovered ? (control.pressed ? control.pushedImage : control.hoveredImage ) : control.normalImage
        }
    }
}
