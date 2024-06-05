#include "RingTheme.h"
#include "RingDef.h"
#include "RingColor.h"
#include "RingTools.h"
#include <QGuiApplication>
#include <QPalette>
#include <QThreadPool>

bool systemDark() {
    QPalette palette = QGuiApplication::palette();
    QColor color = palette.color(QPalette::Window).rgb();
    return color.red() * 0.2126 + color.green() * 0.7152 + color.blue() * 0.0722 <= 255.0f / 2;
}

RingTheme::RingTheme(QObject* parent):QObject{parent}
{
    //初始化强调色对象
    _accentColor = RingColors::getInstance()->Blue();
    //主题模式为亮
    _darkMode = RingThemeType::DarkMode::Light;
    //富文本不开启
    _nativeText = false;
    //开启动画
    _animationEnabled = true;
    //判断系统配色是不是暗
    _systemDark = systemDark();
    //桌面背景图片
    _desktopImagePath = "C:\\Users\\22231\\Desktop\\RingUI\\example\\res\\image\\flower.jpg";
    //不启用毛玻璃背景
    _blurBehindWindowEnabled = false;
    //在该实例化对象上安装事件过滤器
    QGuiApplication::instance()->installEventFilter(this);
    //重新刷新颜色
    refreshColors();
    //绑定主题模式改变信号，和暗模式改变信号
    connect(this, &RingTheme::darkModeChanged, this, [=] {
        Q_EMIT darkChanged();
    });
    //绑定主题暗模式改变信号和槽函数 刷新颜色
    connect(this, &RingTheme::darkChanged, this, [=] { refreshColors(); });
    //绑定强调色改变信号和刷新颜色函数
    connect(this, &RingTheme::accentColorChanged, this, [=] { refreshColors(); });
    //绑定文件监控信号和桌面图片改变信号
    connect(&_watcher, &QFileSystemWatcher::fileChanged, this, [=](const QString &path) {
        Q_EMIT desktopImagePathChanged();
    });
    //绑定毛玻璃效果状态改变信号和槽函数桌面更新
    connect(this, &RingTheme::blurBehindWindowEnabledChanged, this, [=] { checkUpdateDesktopImage(); });
    //启动定时器1s为周期
    startTimer(1000);
}

void RingTheme::refreshColors()
{
    //判断当前模式是否是暗
    auto isDark = dark();
    primaryColor(isDark ? _accentColor->lighter() : _accentColor->dark());
    backgroundColor(isDark ? QColor(0, 0, 0, 255) : QColor(255, 255, 255, 255));
    dividerColor(isDark ? QColor(80, 80, 80, 255) : QColor(210, 210, 210, 255));
    windowBackgroundColor(isDark ? QColor(32, 32, 32, 255) : QColor(237, 237, 237, 255));
    windowActiveBackgroundColor(isDark ? QColor(26, 26, 26, 255) : QColor(243, 243, 243, 255));
    fontPrimaryColor(isDark ? QColor(248, 248, 248, 255) : QColor(7, 7, 7, 255));
    fontSecondaryColor(isDark ? QColor(222, 222, 222, 255) : QColor(102, 102, 102, 255));
    fontTertiaryColor(isDark ? QColor(200, 200, 200, 255) : QColor(153, 153, 153, 255));
    itemNormalColor(isDark ? QColor(255, 255, 255, 0) : QColor(0, 0, 0, 0));
    frameColor(isDark ? QColor(56, 56, 56, qRound(255 * 0.8)) : QColor(243, 243, 243, qRound(255 * 0.8)));
    frameActiveColor(isDark ? QColor(48, 48, 48, qRound(255 * 0.8)) : QColor(255, 255, 255, qRound(255 * 0.8)));
    itemHoverColor(isDark ? QColor(255, 255, 255, qRound(255 * 0.06)) : QColor(0, 0, 0, qRound(255 * 0.03)));
    itemPressColor(isDark ? QColor(255, 255, 255, qRound(255 * 0.09)) : QColor(0, 0, 0, qRound(255 * 0.06)));
    itemCheckColor(isDark ? QColor(255, 255, 255, qRound(255 * 0.12)) : QColor(0, 0, 0, qRound(255 * 0.09)));
}

bool RingTheme::eventFilter(QObject *, QEvent *event)
{
    if (event->type() == QEvent::ApplicationPaletteChange || event->type() == QEvent::ThemeChange)
    {
        _systemDark = systemDark();
        Q_EMIT darkChanged();
        event->accept();
        return true;
    }
    return false;
}


bool RingTheme::dark() const
{
    if(_darkMode == RingThemeType::DarkMode::Dark)
    {
        return true;
    }
    else if(_darkMode == RingThemeType::DarkMode::System)
    {
        return _systemDark;
    }
    else
    {
        return false;
    }
}

void RingTheme::checkUpdateDesktopImage()
{
    if (!_blurBehindWindowEnabled) {
        return;
    }
    QThreadPool::globalInstance()->start([=]() {
        _mutex.lock();
        auto path = RingTools::getInstance()->getWallpaperFilePath();
        if (_desktopImagePath != path) {
            if (!_desktopImagePath.isEmpty()) {
                _watcher.removePath(_desktopImagePath);
            }
            desktopImagePath(path);
            _watcher.addPath(path);
        }
        _mutex.unlock();
    });
}

void RingTheme::timerEvent(QTimerEvent *event) {
    checkUpdateDesktopImage();
}
