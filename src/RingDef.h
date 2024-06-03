#ifndef RINGDEF_H
#define RINGDEF_H

#include <QtQml/qqml.h>


namespace RingSheetType {
    Q_NAMESPACE
    enum Position {
        Left = 0x0000,
        Top = 0x0001,
        Right = 0x0002,
        Bottom = 0x0004,
    };
    //用于将枚举注册到元对象系统中，不注册就无法在QML中使用枚举类型
    Q_ENUM_NS(Position)

    QML_NAMED_ELEMENT(RingSheetType)
}

//枚举主题类型
namespace RingThemeType {
    Q_NAMESPACE
    enum DarkMode {
        System = 0x0000,
        Light = 0x0001,
        Dark = 0x0002,
    };

    Q_ENUM_NS(DarkMode)

    QML_NAMED_ELEMENT(RingThemeType)
}

//枚举控件时间线的类型
namespace RingTimelineType {
    Q_NAMESPACE
    enum Mode {
        Left = 0x0000,
        Right = 0x0001,
        Alternate = 0x0002,
    };

    Q_ENUM_NS(Mode)

    QML_NAMED_ELEMENT(RingTimelineType)
}

//枚举页面的类型
namespace RingPageType {
    Q_NAMESPACE
    enum LaunchMode {
        Standard = 0x0000,
        SingleTask = 0x0001,
        SingleTop = 0x0002,
        SingleInstance = 0x0004
    };

    Q_ENUM_NS(LaunchMode)

    QML_NAMED_ELEMENT(RingPageType)
}

//枚举窗口的类型
namespace RingWindowType {
    Q_NAMESPACE
    enum LaunchMode {
        Standard = 0x0000,
        SingleTask = 0x0001,
        SingleInstance = 0x0002
    };

    Q_ENUM_NS(LaunchMode)

    QML_NAMED_ELEMENT(RingWindowType)
}
//枚举控件树窗口的类型
namespace RingTreeViewType {
    Q_NAMESPACE
    enum SelectionMode {
        None = 0x0000,
        Single = 0x0001,
        Multiple = 0x0002
    };

    Q_ENUM_NS(SelectionMode)

    QML_NAMED_ELEMENT(RingTreeViewType)
}
//枚举布局状态的类型
namespace RingStatusLayoutType {
    Q_NAMESPACE
    enum StatusMode {
        Loading = 0x0000,
        Empty = 0x0001,
        Error = 0x0002,
        Success = 0x0004
    };

    Q_ENUM_NS(StatusMode)

    QML_NAMED_ELEMENT(RingStatusLayoutType)
}

//枚举文本对话框的类型
namespace RingContentDialogType {
    Q_NAMESPACE
    enum ButtonFlag {
        NeutralButton = 0x0001,
        NegativeButton = 0x0002,
        PositiveButton = 0x0004
    };

    Q_ENUM_NS(ButtonFlag)

    QML_NAMED_ELEMENT(RingContentDialogType)
}
//枚举时间拾取器的类型
namespace RingTimePickerType {
    Q_NAMESPACE
    enum HourFormat {
        H = 0x0000,
        HH = 0x0001
    };

    Q_ENUM_NS(HourFormat)

    QML_NAMED_ELEMENT(RingTimePickerType)
}
//枚举日历控件的类型
namespace RingCalendarViewType {
    Q_NAMESPACE
    enum DisplayMode {
        Month = 0x0000,
        Year = 0x0001,
        Decade = 0x0002
    };

    Q_ENUM_NS(DisplayMode)

    QML_NAMED_ELEMENT(RingCalendarViewType)
}
//枚举侧边栏的类型
namespace RingTabViewType {
    Q_NAMESPACE
    enum TabWidthBehavior {
        Equal = 0x0000,
        SizeToContent = 0x0001,
        Compact = 0x0002
    };

    Q_ENUM_NS(TabWidthBehavior)

    enum CloseButtonVisibility {
        Never = 0x0000,
        Always = 0x0001,
        OnHover = 0x0002
    };

    Q_ENUM_NS(CloseButtonVisibility)

    QML_NAMED_ELEMENT(RingTabViewType)
}

//枚举导航控件的类型
namespace RingNavigationViewType {
    Q_NAMESPACE
    enum DisplayMode {
        Open = 0x0000,
        Compact = 0x0001,
        Minimal = 0x0002,
        Auto = 0x0004
    };

    Q_ENUM_NS(DisplayMode)

    enum PageMode {
        Stack = 0x0000,
        NoStack = 0x0001
    };

    Q_ENUM_NS(PageMode)

    QML_NAMED_ELEMENT(RingNavigationViewType)
}


#endif // RINGDEF_H
