import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Basic
import RingUI

Button {
    id:control
    //配置按键只显示图标，默认是图标字体共存
    display: Button.IconOnly
    //定义按键的图标大小
    property int iconSize: 20
    //定义按键图标来源
    property int iconSource
    //定义是否使能该按键
    property bool disabled: false
    //定义按键外围矩形的圆角程度
    property int radius:4
    //定义按键的描述文本
    property string contentDescription: ""
    //定义按键在悬停时的颜色
    property color hoverColor: RingTheme.itemHoverColor
    //定义按键在按压时的颜色
    property color pressedColor: RingTheme.itemPressColor
    //定义按键在正常时的颜色
    property color normalColor: RingTheme.itemNormalColor
    //定义按键在禁用时的颜色
    property color disableColor: RingTheme.itemNormalColor
    //定义图标显示委托组件
    property Component iconDelegate:com_icon
    //定义属性获取当前按键的颜色
    property color color:{
        if(!enabled)
        {
            return disableColor
        }
        if(pressed)
        {
            return pressedColor
        }
        return hovered ? hoverColor : normalColor
    }
    //定义属性获取当前图标的颜色
    property color iconColor:
    {
        if(RingTheme.dark)
        {
            if(!enabled)
            {
                return Qt.rgba(130/255,130/255,130/255,1)
            }
            return Qt.rgba(1,1,1,1)
        }
        else
        {
            if(!enabled)
            {
                return Qt.rgba(161/255,161/255,161/255,1)
            }
            return Qt.rgba(0,0,0,1)
        }
    }
    //定义文本颜色
    property color textColor: RingTheme.fontPrimaryColor

    Accessible.role: Accessible.Button
    Accessible.name: control.text
    Accessible.description: contentDescription
    Accessible.onPressAction: control.clicked()
    focusPolicy:Qt.TabFocus
    padding: 0
    verticalPadding: 8
    horizontalPadding: 8
    enabled: !disabled
    font:RingTextStyle.Caption
    background: Rectangle{
        implicitWidth: 30
        implicitHeight: 30
        radius: control.radius
        color:control.color
        RingFocusRectangle{
            visible: control.activeFocus
        }
    }
    //定义组件用于图标的显示
    Component{
        id:com_icon
        RingIcon{
            id:text_icon
            font.pixelSize: iconSize
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            iconSize: control.iconSize
            iconColor: control.iconColor
            iconSource: control.iconSource
        }
    }
    //定义组件用于加载图标和字体到水平布局
    Component{
        id:com_row
        RowLayout{
            RingLoader{
                sourceComponent: iconDelegate
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                visible: display !== Button.TextOnly
            }
            RingText{
                text:control.text
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                visible: display !== Button.IconOnly
                color: control.textColor
                font: control.font
            }
        }
    }
    //定义组件用于加载图标和字体到垂直布局
    Component{
        id:com_column
        ColumnLayout{
            RingLoader{
                sourceComponent: iconDelegate
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                visible: display !== Button.TextOnly
            }
            RingText{
                text:control.text
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                visible: display !== Button.IconOnly
                color: control.textColor
                font: control.font
            }
        }
    }
    //定义：contentItem 是一个 Item，表示按钮的主要内容。
    //默认情况下，Button 的内容是一个 Label，用于显示按钮的文本。
    //自定义内容：通过设置 contentItem 属性，你可以完全自定义按钮的外观和内容，
    //而不仅仅限于显示文本。你可以将任何 QML 项目（如图像、图标、复杂布局等）放入按钮中
    contentItem:RingLoader{
        sourceComponent: {
            if(display === Button.TextUnderIcon){
                return com_column
            }
            return com_row
        }
    }
    //添加按键解释文本框
    RingTooltip{
        id:tool_tip
        visible: {
            if(control.text === ""){
                return false
            }
            if(control.display !== Button.IconOnly){
                return false
            }
            return hovered
        }
        text:control.text
        delay: 1000
    }


}
