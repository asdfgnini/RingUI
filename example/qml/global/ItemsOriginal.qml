pragma Singleton

import QtQuick 2.15
import RingUI 1.0

RingObject{

    property var navigationView
    property var paneItemMenu

    function rename(item, newName){
        if(newName && newName.trim().length>0){
            item.title = newName;
        }
    }
    RingPaneItem{
        id:item_home
        count: 9
        title: qsTr("Home")
        menuDelegate: paneItemMenu
        infoBadge: RingBadge{
            count: item_home.count
        }
        icon: RingIcons.Home
        url: "qrc:/example/qml/page/T_Home.qml"
        onTap: {
            if(navigationView.getCurrentUrl()){
                item_home.count = 0
            }
            navigationView.push(url)
        }
    }

    RingPaneItemExpander{
        id: item_expander_basic_input
        title: qsTr("Basic Input")
        icon: RingIcons.CheckboxComposite
        RingPaneItem{
            id: item_buttons
            count: 99
            infoBadge: RingBadge{
                count: item_buttons.count
            }
            title: qsTr("Buttons")
            menuDelegate: paneItemMenu
            extra: ({image:"qrc:/example/res/image/control/Button.png",recentlyUpdated:true,desc:qsTr("A control that responds to user input and raisesa Click event.")})
            url: "qrc:/example/qml/page/T_Buttons.qml"
            onTap: {
                item_buttons.count = 0
                navigationView.push(url)
            }
        }
    }

    //分割线
    RingPaneItemSeparator{
        spacing:10
        size:1
    }

    RingPaneItemExpander{
        title: qsTr("Other")
        icon: RingIcons.Shop
        RingPaneItem{
            title: qsTr("OpenGL")
            menuDelegate: paneItemMenu
            url: "qrc:/example/qml/page/T_OpenGL.qml"
            onTap: { navigationView.push(url) }
        }
        RingPaneItem{
            title: qsTr("QRCode")
            menuDelegate: paneItemMenu
            url: "qrc:/example/qml/page/T_QRCode.qml"
            onTap: { navigationView.push(url) }
        }
        RingPaneItem{
            title: qsTr("Tour")
            menuDelegate: paneItemMenu
            url: "qrc:/example/qml/page/T_Tour.qml"
            onTap: { navigationView.push(url) }
        }
        RingPaneItem{
            title: qsTr("Timeline")
            menuDelegate: paneItemMenu
            url: "qrc:/example/qml/page/T_Timeline.qml"
            onTap: { navigationView.push(url) }
        }

    }

    function getRecentlyAddedData(){
        var arr = []
        var items = navigationView.getItems();
        for(var i=0;i<items.length;i++){
            var item = items[i]
            if(item instanceof RingPaneItem && item.extra && item.extra.recentlyAdded){
                arr.push(item)
            }
        }
        arr.sort(function(o1,o2){ return o2.extra.order-o1.extra.order })
        return arr
    }

    function getRecentlyUpdatedData(){
        var arr = []
        var items = navigationView.getItems();
        for(var i=0;i<items.length;i++){
            var item = items[i]
            if(item instanceof RingPaneItem && item.extra && item.extra.recentlyUpdated){
                arr.push(item)
            }
        }
        return arr
    }

    function getSearchData(){
        if(!navigationView){
            return
        }
        var arr = []
        var items = navigationView.getItems();
        for(var i=0;i<items.length;i++){
            var item = items[i]
            if(item instanceof RingPaneItem){
                if (item.parent instanceof RingPaneItemExpander)
                {
                    arr.push({title:`${item.parent.title} -> ${item.title}`,key:item.key})
                }
                else
                    arr.push({title:item.title,key:item.key})
            }
        }
        return arr
    }

    function startPageByItem(data){
        navigationView.startPageByItem(data)
    }

}
