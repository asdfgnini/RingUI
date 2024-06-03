import QtQuick

//设置Loader组件，并设置当Loader组件销毁时，将加载的组件清空
Loader {
    Component.onDestruction: sourceComponent = undefined

}
