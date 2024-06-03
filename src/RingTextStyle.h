#ifndef RINGTEXTSTYLE_H
#define RINGTEXTSTYLE_H


#include <QFont>
#include "RingSingle.h"
#include "RingRegProperty.h"
#include <QObject>
#include <QtQml/qqml.h>

class RingTextStyle:public QObject
{
    Q_OBJECT
    Q_PROPERTY_AUTO(QString, family)
    Q_PROPERTY_AUTO(QFont, Caption);
    Q_PROPERTY_AUTO(QFont, Body);
    Q_PROPERTY_AUTO(QFont, BodyStrong);
    Q_PROPERTY_AUTO(QFont, Subtitle);
    Q_PROPERTY_AUTO(QFont, Title);
    Q_PROPERTY_AUTO(QFont, TitleLarge);
    Q_PROPERTY_AUTO(QFont, Display);
    QML_NAMED_ELEMENT(RingTextStyle)
    QML_SINGLETON
private:
    explicit RingTextStyle(QObject *parent = nullptr);

public:
    RINGSINGLE(RingTextStyle)
    //获取指向该类实例化对象的指针
    static RingTextStyle *create(QQmlEngine *, QJSEngine *) { return getInstance(); }

};



#endif // RINGTEXTSTYLE_H
