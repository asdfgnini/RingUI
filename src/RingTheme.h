#ifndef RINGTHEME_H
#define RINGTHEME_H


#include <QtQml/qqml.h>
#include <QJsonArray>
#include <QJsonObject>
#include <QTimer>
#include <QObject>
#include "RingRegProperty.h"
#include <RingAccentColor.h>
#include <QColor>
#include <RingSingle.h>
#include <QFileSystemWatcher>
#include <QMutex>

class RingTheme : public QObject{
    Q_OBJECT
    Q_PROPERTY(bool dark READ dark NOTIFY darkChanged)
    Q_PROPERTY_AUTO_P(RingAccentColor*, accentColor);
    Q_PROPERTY_AUTO(QColor, primaryColor);//原色
    Q_PROPERTY_AUTO(QColor, backgroundColor);
    Q_PROPERTY_AUTO(QColor, dividerColor);
    Q_PROPERTY_AUTO(QColor, windowBackgroundColor);
    Q_PROPERTY_AUTO(QColor, windowActiveBackgroundColor);
    Q_PROPERTY_AUTO(QColor, fontPrimaryColor);
    Q_PROPERTY_AUTO(QColor, fontSecondaryColor);
    Q_PROPERTY_AUTO(QColor, fontTertiaryColor);
    Q_PROPERTY_AUTO(QColor, itemNormalColor);
    Q_PROPERTY_AUTO(QColor, frameColor);
    Q_PROPERTY_AUTO(QColor, frameActiveColor);
    Q_PROPERTY_AUTO(QColor, itemHoverColor);
    Q_PROPERTY_AUTO(QColor, itemPressColor);
    Q_PROPERTY_AUTO(QColor, itemCheckColor);
    Q_PROPERTY_AUTO(QString, desktopImagePath);
    Q_PROPERTY_AUTO(int, darkMode);
    Q_PROPERTY_AUTO(bool, nativeText);
    Q_PROPERTY_AUTO(bool, animationEnabled);
    Q_PROPERTY_AUTO(bool, blurBehindWindowEnabled);
    QML_NAMED_ELEMENT(RingTheme)//意思就是向QML中注册一个叫宏参数名字的对象
    /*
    QML_SINGLETON用于标记 C++ 类为 QML 单例的宏。在 QML 中，单例是一种设计模
    式，其中一个类只有一个实例，并且该实例在应用程序的整个生命周期
    中都可以被全局访问。通过将类标记为单例，可以在 QML 中全局访问该
    类的实例，而无需手动实例化对象。意思就在QML内该类为一个全局单例对象
    */
    QML_SINGLETON
private:
    explicit RingTheme(QObject *parent = nullptr);
    //在该类实例化对象上安装事件过滤器
    bool eventFilter(QObject *obj,QEvent *event) override;
    //重新刷新颜色
    void refreshColors();
protected:
    //定时器事件回调
    void timerEvent(QTimerEvent* event) override;

    void checkUpdateDesktopImage();
public:
    RINGSINGLE(RingTheme);//在C++范围内注册一个全局的单例
    //注册属性dark的修改信号
    Q_SIGNAL void darkChanged();
    //获取指向该类实例化对象的指针
    static RingTheme *create(QQmlEngine *, QJSEngine *) { return getInstance(); }

    bool dark() const;
private:
    bool _systemDark;
    //文件系统监控者
    QFileSystemWatcher _watcher;
    QMutex _mutex;
};




#endif // RINGTHEME_H
