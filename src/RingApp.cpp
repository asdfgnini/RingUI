#include "RingApp.h"


RingApp::RingApp(QObject* parent):QObject{parent}
{
    //不适用系统的应用栏
    _useSystemAppBar = false;
}

RingApp::~RingApp() = default;


//初始化一个RingApp对象
void RingApp::init(QObject *target, QLocale locale)
{
    _locale = std::move(locale);
    _engine = qmlEngine(target);

}


[[maybe_unused]] QJsonArray RingApp::iconDatas(const QString &keyword)
{
    QJsonArray arr;
    QMetaEnum enumType = Ring_Icons::staticMetaObject.enumerator(Ring_Icons::staticMetaObject.indexOfEnumerator("Ring_IconType"));
    for (int i = 0; i <= enumType.keyCount() - 1; ++i) {
        QString name = enumType.key(i);
        int icon = enumType.value(i);
        if (keyword.isEmpty() || name.contains(keyword)) {
            QJsonObject obj;
            obj.insert("name", name);
            obj.insert("icon", icon);
            arr.append(obj);
        }
    }
    return arr;
}
