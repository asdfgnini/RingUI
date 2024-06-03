import QtQuick
import QtQuick.Controls
import RingUI

//采用的图标字体库，显示图标对应的unicode编码就会显示对应的图标
//主要图标字体库规定了图标的形状，但是没有规定颜色，所以颜色我们可以自己配置
Text {
    id:control
    //定义图标字体库的来源
    property int iconSource
    //定义图标字体库的显示大小
    property int iconSize: 20
    //定义图标显示的颜色，与主题模式相反显示
    property color iconColor:  FluTheme.dark ? "#FFFFFF" : "#000000"
    //定义显示的字体样式
    font.family:font_loader.name
    font.pixelSize: iconSize
    //设置字体水平对齐方式
    horizontalAlignment: Text.AlignHCenter
    //设置字体垂直对其方式
    verticalAlignment: Text.AlignVCenter
    //设置字体颜色
    color: iconColor
    //设置显示的内容,调用js的方法将字符代码转换为unicode代码，然后在转换为十六进制字符串
    text:(String.fromCharCode(iconSource).toString(16))
    //设置字体显示的透明度
    opacity: iconSource > 0

    FontLoader{
        id:font_loader
        source: "qrc:/qt/qml/RingUI/Font/FluentIcons.ttf"
    }
}
