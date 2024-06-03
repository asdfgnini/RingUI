#ifndef RINGACCENTCOLOR_H
#define RINGACCENTCOLOR_H

#include <QObject>
#include "RingRegProperty.h"
#include <QColor>
#include <QtQml/qqml.h>

//定义强调色类
class RingAccentColor : public QObject
{
    Q_OBJECT
    Q_PROPERTY_AUTO(QColor,darkest);  //最暗
    Q_PROPERTY_AUTO(QColor,darker);
    Q_PROPERTY_AUTO(QColor,dark);
    Q_PROPERTY_AUTO(QColor,normal);  //正常
    Q_PROPERTY_AUTO(QColor,light);
    Q_PROPERTY_AUTO(QColor,lighter);
    Q_PROPERTY_AUTO(QColor,lightest); //最亮
    //使用QML_NAMED_ELEMENT向QML中注册这个对象，在QML中的名字为宏参数，
    QML_NAMED_ELEMENT(RingAccentColor)
public:
    explicit RingAccentColor(QObject *parent = nullptr);
};

#endif // RINGACCENTCOLOR_H
