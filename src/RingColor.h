#ifndef RINGCOLOR_H
#define RINGCOLOR_H

#include <QObject>
#include "RingRegProperty.h"
#include <QColor>
#include "RingAccentColor.h"
#include "RingSingle.h"

class RingColors:public QObject
{
    Q_OBJECT
    Q_PROPERTY_AUTO(QColor, Transparent)//透明度;
    Q_PROPERTY_AUTO(QColor, Black);
    Q_PROPERTY_AUTO(QColor, White);
    Q_PROPERTY_AUTO(QColor, Grey10);
    Q_PROPERTY_AUTO(QColor, Grey20);
    Q_PROPERTY_AUTO(QColor, Grey30);
    Q_PROPERTY_AUTO(QColor, Grey40);
    Q_PROPERTY_AUTO(QColor, Grey50);
    Q_PROPERTY_AUTO(QColor, Grey60);
    Q_PROPERTY_AUTO(QColor, Grey70);
    Q_PROPERTY_AUTO(QColor, Grey80);
    Q_PROPERTY_AUTO(QColor, Grey90);
    Q_PROPERTY_AUTO(QColor, Grey100);
    Q_PROPERTY_AUTO(QColor, Grey110);
    Q_PROPERTY_AUTO(QColor, Grey120);
    Q_PROPERTY_AUTO(QColor, Grey130);
    Q_PROPERTY_AUTO(QColor, Grey140);
    Q_PROPERTY_AUTO(QColor, Grey150);
    Q_PROPERTY_AUTO(QColor, Grey160);
    Q_PROPERTY_AUTO(QColor, Grey170);
    Q_PROPERTY_AUTO(QColor, Grey180);
    Q_PROPERTY_AUTO(QColor, Grey190);
    Q_PROPERTY_AUTO(QColor, Grey200);
    Q_PROPERTY_AUTO(QColor, Grey210);
    Q_PROPERTY_AUTO(QColor, Grey220);
    Q_PROPERTY_AUTO_P(RingAccentColor*, Yellow);
    Q_PROPERTY_AUTO_P(RingAccentColor*, Orange);
    Q_PROPERTY_AUTO_P(RingAccentColor*, Red);
    Q_PROPERTY_AUTO_P(RingAccentColor*, Magenta);
    Q_PROPERTY_AUTO_P(RingAccentColor*, Purple);
    Q_PROPERTY_AUTO_P(RingAccentColor*, Blue);
    Q_PROPERTY_AUTO_P(RingAccentColor*, Teal);
    Q_PROPERTY_AUTO_P(RingAccentColor*, Green);
    QML_NAMED_ELEMENT(RingColors)
    QML_SINGLETON
private:
    explicit RingColors(QObject *parent = nullptr);
public:
    RINGSINGLE(RingColors)
    //告诉编译器函数返回值可能未被使用不要抛出变量未使用的警告
    [[maybe_unused]] Q_INVOKABLE RingAccentColor *createAccentColor(const QColor &primaryColor);
    //留给外部的调用接口，用于获取当前类的实例化对象的指针
    static RingColors *create(QQmlEngine *, QJSEngine *) { return getInstance(); }
};







#endif // RINGCOLOR_H
