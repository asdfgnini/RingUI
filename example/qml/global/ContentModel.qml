import QtQuick 2.15
import QtQml
import QtQml.Models


ListModel {
    id:demomodel
    ListElement{
        name:"Buttons"
        source:"qrc:/example/qml/page/T_Buttons.qml"
        visible:true
        group:"通用"
        groupOpen:true
    }



    function updateSection(section, isOpen) {
        for (var i = 0; i < count; ++i) {
            var obj = get(i)
            if (obj["group"] === section) {
                setProperty(i, "groupOpen", isOpen)
            }
        }
    }
    function search(text) {
        var i = 0
        if (text.length <= 0) {
            for ( i = 0; i < count; ++i) {
                setProperty(i, "visible", true)
            }
        } else {
            var lowerText = String(text).toLowerCase()
            for (i = 0; i < count; ++i) {
                var obj = get(i)
                if (qsTr(obj["name"]).toLowerCase().indexOf(lowerText) >= 0) {
                    setProperty(i, "visible", true)
                } else {
                    setProperty(i, "visible", false)
                }
            }
        }
    }
}




