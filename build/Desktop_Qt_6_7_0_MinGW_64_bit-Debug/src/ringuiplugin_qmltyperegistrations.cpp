/****************************************************************************
** Generated QML type registration code
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <QtQml/qqml.h>
#include <QtQml/qqmlmoduleregistration.h>

#include <RingAccentColor.h>
#include <RingApp.h>
#include <RingColor.h>
#include <RingDef.h>
#include <RingFrameless.h>
#include <RingIconDef.h>
#include <RingRectangle.h>
#include <RingTextStyle.h>
#include <RingTheme.h>
#include <RingTools.h>


#if !defined(QT_STATIC)
#define Q_QMLTYPE_EXPORT Q_DECL_EXPORT
#else
#define Q_QMLTYPE_EXPORT
#endif
Q_QMLTYPE_EXPORT void qml_register_types_RingUI()
{
    qmlRegisterTypesAndRevisions<RingAccentColor>("RingUI", 1);
    qmlRegisterTypesAndRevisions<RingApp>("RingUI", 1);
    {
        Q_CONSTINIT static auto metaType = QQmlPrivate::metaTypeForNamespace(
            [](const QtPrivate::QMetaTypeInterface *) {return &RingCalendarViewType::staticMetaObject;},
            "RingCalendarViewType");
        QMetaType(&metaType).id();
    }
    qmlRegisterNamespaceAndRevisions(&RingCalendarViewType::staticMetaObject, "RingUI", 1, nullptr, &RingCalendarViewType::staticMetaObject, nullptr);
    qmlRegisterTypesAndRevisions<RingColors>("RingUI", 1);
    {
        Q_CONSTINIT static auto metaType = QQmlPrivate::metaTypeForNamespace(
            [](const QtPrivate::QMetaTypeInterface *) {return &RingContentDialogType::staticMetaObject;},
            "RingContentDialogType");
        QMetaType(&metaType).id();
    }
    qmlRegisterNamespaceAndRevisions(&RingContentDialogType::staticMetaObject, "RingUI", 1, nullptr, &RingContentDialogType::staticMetaObject, nullptr);
    qmlRegisterTypesAndRevisions<RingFrameless>("RingUI", 1);
    qmlRegisterAnonymousType<QQuickItem, 254>("RingUI", 1);
    {
        Q_CONSTINIT static auto metaType = QQmlPrivate::metaTypeForNamespace(
            [](const QtPrivate::QMetaTypeInterface *) {return &RingNavigationViewType::staticMetaObject;},
            "RingNavigationViewType");
        QMetaType(&metaType).id();
    }
    qmlRegisterNamespaceAndRevisions(&RingNavigationViewType::staticMetaObject, "RingUI", 1, nullptr, &RingNavigationViewType::staticMetaObject, nullptr);
    {
        Q_CONSTINIT static auto metaType = QQmlPrivate::metaTypeForNamespace(
            [](const QtPrivate::QMetaTypeInterface *) {return &RingPageType::staticMetaObject;},
            "RingPageType");
        QMetaType(&metaType).id();
    }
    qmlRegisterNamespaceAndRevisions(&RingPageType::staticMetaObject, "RingUI", 1, nullptr, &RingPageType::staticMetaObject, nullptr);
    qmlRegisterTypesAndRevisions<RingRectangle>("RingUI", 1);
    {
        Q_CONSTINIT static auto metaType = QQmlPrivate::metaTypeForNamespace(
            [](const QtPrivate::QMetaTypeInterface *) {return &RingSheetType::staticMetaObject;},
            "RingSheetType");
        QMetaType(&metaType).id();
    }
    qmlRegisterNamespaceAndRevisions(&RingSheetType::staticMetaObject, "RingUI", 1, nullptr, &RingSheetType::staticMetaObject, nullptr);
    {
        Q_CONSTINIT static auto metaType = QQmlPrivate::metaTypeForNamespace(
            [](const QtPrivate::QMetaTypeInterface *) {return &RingStatusLayoutType::staticMetaObject;},
            "RingStatusLayoutType");
        QMetaType(&metaType).id();
    }
    qmlRegisterNamespaceAndRevisions(&RingStatusLayoutType::staticMetaObject, "RingUI", 1, nullptr, &RingStatusLayoutType::staticMetaObject, nullptr);
    {
        Q_CONSTINIT static auto metaType = QQmlPrivate::metaTypeForNamespace(
            [](const QtPrivate::QMetaTypeInterface *) {return &RingTabViewType::staticMetaObject;},
            "RingTabViewType");
        QMetaType(&metaType).id();
    }
    qmlRegisterNamespaceAndRevisions(&RingTabViewType::staticMetaObject, "RingUI", 1, nullptr, &RingTabViewType::staticMetaObject, nullptr);
    qmlRegisterTypesAndRevisions<RingTextStyle>("RingUI", 1);
    qmlRegisterTypesAndRevisions<RingTheme>("RingUI", 1);
    {
        Q_CONSTINIT static auto metaType = QQmlPrivate::metaTypeForNamespace(
            [](const QtPrivate::QMetaTypeInterface *) {return &RingThemeType::staticMetaObject;},
            "RingThemeType");
        QMetaType(&metaType).id();
    }
    qmlRegisterNamespaceAndRevisions(&RingThemeType::staticMetaObject, "RingUI", 1, nullptr, &RingThemeType::staticMetaObject, nullptr);
    {
        Q_CONSTINIT static auto metaType = QQmlPrivate::metaTypeForNamespace(
            [](const QtPrivate::QMetaTypeInterface *) {return &RingTimePickerType::staticMetaObject;},
            "RingTimePickerType");
        QMetaType(&metaType).id();
    }
    qmlRegisterNamespaceAndRevisions(&RingTimePickerType::staticMetaObject, "RingUI", 1, nullptr, &RingTimePickerType::staticMetaObject, nullptr);
    {
        Q_CONSTINIT static auto metaType = QQmlPrivate::metaTypeForNamespace(
            [](const QtPrivate::QMetaTypeInterface *) {return &RingTimelineType::staticMetaObject;},
            "RingTimelineType");
        QMetaType(&metaType).id();
    }
    qmlRegisterNamespaceAndRevisions(&RingTimelineType::staticMetaObject, "RingUI", 1, nullptr, &RingTimelineType::staticMetaObject, nullptr);
    qmlRegisterTypesAndRevisions<RingTools>("RingUI", 1);
    {
        Q_CONSTINIT static auto metaType = QQmlPrivate::metaTypeForNamespace(
            [](const QtPrivate::QMetaTypeInterface *) {return &RingTreeViewType::staticMetaObject;},
            "RingTreeViewType");
        QMetaType(&metaType).id();
    }
    qmlRegisterNamespaceAndRevisions(&RingTreeViewType::staticMetaObject, "RingUI", 1, nullptr, &RingTreeViewType::staticMetaObject, nullptr);
    {
        Q_CONSTINIT static auto metaType = QQmlPrivate::metaTypeForNamespace(
            [](const QtPrivate::QMetaTypeInterface *) {return &RingWindowType::staticMetaObject;},
            "RingWindowType");
        QMetaType(&metaType).id();
    }
    qmlRegisterNamespaceAndRevisions(&RingWindowType::staticMetaObject, "RingUI", 1, nullptr, &RingWindowType::staticMetaObject, nullptr);
    {
        Q_CONSTINIT static auto metaType = QQmlPrivate::metaTypeForNamespace(
            [](const QtPrivate::QMetaTypeInterface *) {return &Ring_Icons::staticMetaObject;},
            "Ring_Icons");
        QMetaType(&metaType).id();
    }
    qmlRegisterNamespaceAndRevisions(&Ring_Icons::staticMetaObject, "RingUI", 1, nullptr, &Ring_Icons::staticMetaObject, nullptr);
    qmlRegisterModule("RingUI", 1, 0);
}

static const QQmlModuleRegistration ringUIRegistration("RingUI", qml_register_types_RingUI);
