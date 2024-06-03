#ifndef RINGFRAMELESS_H
#define RINGFRAMELESS_H

#include <QObject>
#include <QQuickItem>
#include <QAbstractNativeEventFilter>
#include <QQmlProperty>
#include "RingRegProperty.h"


#if (QT_VERSION >= QT_VERSION_CHECK(6, 0, 0))
using QT_NATIVE_EVENT_RESULT_TYPE = qintptr;
using QT_ENTER_EVENT_TYPE = QEnterEvent;
#else
using QT_NATIVE_EVENT_RESULT_TYPE = long;
using QT_ENTER_EVENT_TYPE = QEvent;
#endif

class RingFrameless:public QQuickItem,QAbstractNativeEventFilter
{
    Q_OBJECT
    Q_PROPERTY_AUTO_P(QQuickItem*, appbar)
    Q_PROPERTY_AUTO_P(QQuickItem*, maximizeButton)
    Q_PROPERTY_AUTO_P(QQuickItem*, minimizedButton)
    Q_PROPERTY_AUTO_P(QQuickItem*, closeButton)
    Q_PROPERTY_AUTO(bool, topmost)
    Q_PROPERTY_AUTO(bool, disabled)
    Q_PROPERTY_AUTO(bool, fixSize)
    QML_NAMED_ELEMENT(RingFrameless)

public:
    explicit RingFrameless(QQuickItem* parent = nullptr);

    ~RingFrameless() override;
    //组件完成回调
    void componentComplete()override;
    //原生事件过滤器
    [[maybe_unused]] bool nativeEventFilter(const QByteArray &eventType, void *message, QT_NATIVE_EVENT_RESULT_TYPE *result) override;
    //全屏显示回调
    [[maybe_unused]] Q_INVOKABLE void showFullScreen();
    //显示最大化
    Q_INVOKABLE void showMaximized();
    //显示最小化
    [[maybe_unused]] Q_INVOKABLE void showMinimized();
    //正常显示
    Q_INVOKABLE void showNormal();
    //设置隐藏测试可见性
    Q_INVOKABLE void setHitTestVisible(QQuickItem *);
    //删除组件的回调
    [[maybe_unused]] Q_INVOKABLE void onDestruction();

protected:
    bool eventFilter(QObject *obj, QEvent *event) override;

private:
    bool _isFullScreen();

    bool _isMaximized();

    void _updateCursor(int edges);

    void _setWindowTopmost(bool topmost);

    void _showSystemMenu(QPoint point);

    bool _hitAppBar();

    bool _hitMaximizeButton();

    void _setMaximizePressed(bool val);

    void _setMaximizeHovered(bool val);
private:
    quint64 _current = 0;
    int _edges = 0;
    int _margins = 8;
    quint64 _clickTimer = 0;
    bool _isWindows11OrGreater = false;
    QList<QPointer<QQuickItem>> _hitTestList;

};









#endif // RINGFRAMELESS_H
