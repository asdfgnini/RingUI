#ifndef RINGRECTANGLE_H
#define RINGRECTANGLE_H

#include <QQuickItem>
#include <QQuickPaintedItem>
#include <QPainter>
#include "RingRegProperty.h"

/**
 * @brief The RingRectangle class
 */
class RingRectangle : public QQuickPaintedItem {
    Q_OBJECT
    Q_PROPERTY_AUTO(QColor, color)
    Q_PROPERTY_AUTO(QList<int>, radius)
    QML_NAMED_ELEMENT(RingRectangle)
public:
    explicit RingRectangle(QQuickItem *parent = nullptr);

    void paint(QPainter *painter) override;
};



#endif // RINGRECTANGLE_H
