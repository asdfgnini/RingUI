import QtQuick 2.15
import QtQuick.Controls 2.15
import RingUI 1.0

RingObject {
    property var root;
    property int layoutY: 75
    id:control
    RingObject{
        id:mcontrol
        property string const_success: "success";
        property string const_info:    "info";
        property string const_warning: "warning";
        property string const_error:   "error";
        property int maxWidth: 300;
        property var screenLayout: null;
        function create(type,text,duration,moremsg){
            if(screenLayout){
                var last = screenLayout.getLastloader();
                if(last.type === type && last.text === text && moremsg === last.moremsg){
                    last.duration = duration
                    if (duration > 0) last.restart();
                    return last;
                }
            }
            initScreenLayout();
            return contentComponent.createObject(screenLayout,{
                                                    type:type,
                                                    text:text,
                                                    duration:duration,
                                                    moremsg:moremsg,
                                                });
        }
        function createCustom(itemcomponent,duration){
            initScreenLayout();
            if(itemcomponent){
                return contentComponent.createObject(screenLayout,{itemcomponent:itemcomponent,duration:duration});
            }
        }
        function initScreenLayout(){
            if(screenLayout == null){
                screenLayout = screenlayoutComponent.createObject(root);
                screenLayout.y = control.layoutY;
                screenLayout.z = 100000;
            }
        }
        Component{
            id:screenlayoutComponent
            Column{
                parent: Overlay.overlay
                z:999
                spacing: 20
                width: root.width
                move: Transition {
                    NumberAnimation {
                        properties: "y"
                        easing.type: Easing.OutCubic
                        duration: RingTheme.animationEnabled ? 333 : 0
                    }
                }
                onChildrenChanged: if(children.length === 0)  destroy();
                function getLastloader(){
                    if(children.length > 0){
                        return children[children.length - 1];
                    }
                    return null;
                }
            }
        }
        Component{
            id:contentComponent
            Item{
                id:content;
                property int duration: 1500
                property var itemcomponent
                property string type
                property string text
                property string moremsg
                width:  parent.width;
                height: loader.height;
                function close(){
                    content.destroy();
                }
                function restart(){
                    delayTimer.restart();
                }
                Timer {
                    id:delayTimer
                    interval: duration;
                    running: duration > 0;
                    repeat: duration > 0
                    onTriggered: content.close();
                }
                RingLoader{
                    id:loader;
                    x:(parent.width - width) / 2;
                    property var _super: content;
                    scale: item ? 1 : 0;
                    asynchronous: true
                    Behavior on scale {
                        enabled: RingTheme.animationEnabled
                        NumberAnimation {
                            easing.type: Easing.OutCubic
                            duration: 167
                        }
                    }
                    sourceComponent:itemcomponent ? itemcomponent : mcontrol.fluent_sytle;
                }
            }
        }
        property Component fluent_sytle:  Rectangle{
            width:  rowlayout.width  + (btn_close.visible ? 30 : 48);
            height: rowlayout.height + 20;
            color: {
                if(RingTheme.dark){
                    switch(_super.type){
                    case mcontrol.const_success: return Qt.rgba(57/255,61/255,27/255,1);
                    case mcontrol.const_warning: return Qt.rgba(67/255,53/255,25/255,1);
                    case mcontrol.const_info:    return Qt.rgba(39/255,39/255,39/255,1);
                    case mcontrol.const_error:   return Qt.rgba(68/255,39/255,38/255,1);
                    }
                    return Qt.rgba(255,255,255,1)
                }else{
                    switch(_super.type){
                    case mcontrol.const_success: return "#dff6dd";
                    case mcontrol.const_warning: return "#fff4ce";
                    case mcontrol.const_info:    return "#f4f4f4";
                    case mcontrol.const_error:   return "#fde7e9";
                    }
                    return "#FFFFFF"
                }
            }
            RingShadow{
                radius: 4
            }
            radius: 4
            border.width: 1
            border.color: {
                if(RingTheme.dark){
                    switch(_super.type){
                    case mcontrol.const_success: return Qt.rgba(56/255,61/255,27/255,1);
                    case mcontrol.const_warning: return Qt.rgba(66/255,53/255,25/255,1);
                    case mcontrol.const_info:    return Qt.rgba(38/255,39/255,39/255,1);
                    case mcontrol.const_error:   return Qt.rgba(67/255,39/255,38/255,1);
                    }
                    return "#FFFFFF"
                }else{
                    switch(_super.type){
                    case mcontrol.const_success: return "#d2e8d0";
                    case mcontrol.const_warning: return "#f0e6c2";
                    case mcontrol.const_info:    return "#e6e6e6";
                    case mcontrol.const_error:   return "#eed9db";
                    }
                    return "#FFFFFF"
                }
            }
            Row{
                id:rowlayout
                x:20;
                y:(parent.height - height) / 2;
                spacing: 10
                RingIcon{
                    iconSource:{
                        switch(_super.type){
                        case mcontrol.const_success: return RingIcons.CompletedSolid;
                        case mcontrol.const_warning: return RingIcons.InfoSolid;
                        case mcontrol.const_info:    return RingIcons.InfoSolid;
                        case mcontrol.const_error:   return RingIcons.StatusErrorFull;
                        }RingIcons.StatusErrorFull
                        return RingIcons.FA_info_circle
                    }
                    iconSize:20
                    iconColor: {
                        if(RingTheme.dark){
                            switch(_super.type){
                            case mcontrol.const_success: return Qt.rgba(108/255,203/255,95/255,1);
                            case mcontrol.const_warning: return Qt.rgba(252/255,225/255,0/255,1);
                            case mcontrol.const_info:    return RingTheme.primaryColor;
                            case mcontrol.const_error:   return Qt.rgba(255/255,153/255,164/255,1);
                            }
                            return "#FFFFFF"
                        }else{
                            switch(_super.type){
                            case mcontrol.const_success: return "#0f7b0f";
                            case mcontrol.const_warning: return "#9d5d00";
                            case mcontrol.const_info:    return "#0066b4";
                            case mcontrol.const_error:   return "#c42b1c";
                            }
                            return "#FFFFFF"
                        }
                    }
                }

                Column{
                    spacing: 5
                    RingText{
                        text:_super.text
                        wrapMode: Text.WrapAnywhere
                        width: Math.min(implicitWidth,mcontrol.maxWidth)
                    }
                    RingText{
                        text: _super.moremsg
                        visible: _super.moremsg
                        wrapMode : Text.WrapAnywhere
                        textColor: RingColors.Grey120
                        width: Math.min(implicitWidth,mcontrol.maxWidth)
                    }
                }

                RingIconButton{
                    id:btn_close
                    iconSource: RingIcons.ChromeClose
                    iconSize: 10
                    y:5
                    visible: _super.duration<=0
                    iconColor: {
                        if(RingTheme.dark){
                            switch(_super.type){
                            case mcontrol.const_success: return Qt.rgba(108/255,203/255,95/255,1);
                            case mcontrol.const_warning: return Qt.rgba(252/255,225/255,0/255,1);
                            case mcontrol.const_info:    return RingTheme.primaryColor;
                            case mcontrol.const_error:   return Qt.rgba(255/255,153/255,164/255,1);
                            }
                            return "#FFFFFF"
                        }else{
                            switch(_super.type){
                            case mcontrol.const_success: return "#0f7b0f";
                            case mcontrol.const_warning: return "#9d5d00";
                            case mcontrol.const_info:    return "#0066b4";
                            case mcontrol.const_error:   return "#c42b1c";
                            }
                            return "#FFFFFF"
                        }
                    }
                    onClicked: _super.close()
                }
            }
        }
    }
    function showSuccess(text,duration=1000,moremsg){
        return mcontrol.create(mcontrol.const_success,text,duration,moremsg ? moremsg : "");
    }
    function showInfo(text,duration=1000,moremsg){
        return mcontrol.create(mcontrol.const_info,text,duration,moremsg ? moremsg : "");
    }
    function showWarning(text,duration=1000,moremsg){
        return mcontrol.create(mcontrol.const_warning,text,duration,moremsg ? moremsg : "");
    }
    function showError(text,duration=1000,moremsg){
        return mcontrol.create(mcontrol.const_error,text,duration,moremsg ? moremsg : "");
    }
    function showCustom(itemcomponent,duration=1000){
        return mcontrol.createCustom(itemcomponent,duration);
    }
    function clearAllInfo(){
        if(mcontrol.screenLayout != null) {
            mcontrol.screenLayout.destroy()
            mcontrol.screenLayout = null
        }

        return true
    }
}
