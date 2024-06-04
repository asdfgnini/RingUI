#ifndef RINGAPP_H
#define RINGAPP_H

#include <QObject>
#include "RingRegProperty.h"
#include <QtQml/qqml.h>
#include <RingSingle.h>
#include <QJsonObject>
#include <QJsonArray>
#include <QTranslator>
#include "RingIconDef.h"

class RingApp : public QObject
{
    Q_OBJECT
    Q_PROPERTY_AUTO(bool, useSystemAppBar)
    Q_PROPERTY_AUTO(QString, windowIcon)
    Q_PROPERTY_AUTO(QLocale, locale)
    QML_NAMED_ELEMENT(RingApp)
    QML_SINGLETON

private:
    explicit RingApp(QObject* parent = nullptr);

    ~RingApp() override;
public:
    RINGSINGLE(RingApp)
    // 获取RingApp 实例化对象的指针
    static RingApp *create(QQmlEngine *, QJSEngine *) { return getInstance(); }
    //将函数注册到元对象系统内，供QML使用
    Q_INVOKABLE void init(QObject *target, QLocale locale = QLocale::system());

    [[maybe_unused]] Q_INVOKABLE static QJsonArray iconDatas(const QString &keyword = "");
private:
    QQmlEngine *_engine{};
    QTranslator *_translator = nullptr;

};



#endif // RINGAPP_H
