/****************************************************************************
** Meta object code from reading C++ file 'RingApp.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.7.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../../src/RingApp.h"
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'RingApp.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 68
#error "This file was generated using the moc from 6.7.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

#ifndef Q_CONSTINIT
#define Q_CONSTINIT
#endif

QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
QT_WARNING_DISABLE_GCC("-Wuseless-cast")
namespace {

#ifdef QT_MOC_HAS_STRINGDATA
struct qt_meta_stringdata_CLASSRingAppENDCLASS_t {};
constexpr auto qt_meta_stringdata_CLASSRingAppENDCLASS = QtMocHelpers::stringData(
    "RingApp",
    "QML.Element",
    "QML.Singleton",
    "true",
    "useSystemAppBarChanged",
    "",
    "windowIconChanged",
    "localeChanged",
    "init",
    "target",
    "locale",
    "iconDatas",
    "keyword",
    "useSystemAppBar",
    "windowIcon"
);
#else  // !QT_MOC_HAS_STRINGDATA
#error "qtmochelpers.h not found or too old."
#endif // !QT_MOC_HAS_STRINGDATA
} // unnamed namespace

Q_CONSTINIT static const uint qt_meta_data_CLASSRingAppENDCLASS[] = {

 // content:
      12,       // revision
       0,       // classname
       2,   14, // classinfo
       7,   18, // methods
       3,   75, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       3,       // signalCount

 // classinfo: key, value
       1,    0,
       2,    3,

 // signals: name, argc, parameters, tag, flags, initial metatype offsets
       4,    0,   60,    5, 0x06,    4 /* Public */,
       6,    0,   61,    5, 0x06,    5 /* Public */,
       7,    0,   62,    5, 0x06,    6 /* Public */,

 // methods: name, argc, parameters, tag, flags, initial metatype offsets
       8,    2,   63,    5, 0x02,    7 /* Public */,
       8,    1,   68,    5, 0x22,   10 /* Public | MethodCloned */,
      11,    1,   71,    5, 0x02,   12 /* Public */,
      11,    0,   74,    5, 0x22,   14 /* Public | MethodCloned */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // methods: parameters
    QMetaType::Void, QMetaType::QObjectStar, QMetaType::QLocale,    9,   10,
    QMetaType::Void, QMetaType::QObjectStar,    9,
    QMetaType::QJsonArray, QMetaType::QString,   12,
    QMetaType::QJsonArray,

 // properties: name, type, flags
      13, QMetaType::Bool, 0x00015003, uint(0), 0,
      14, QMetaType::QString, 0x00015003, uint(1), 0,
      10, QMetaType::QLocale, 0x00015003, uint(2), 0,

       0        // eod
};

Q_CONSTINIT const QMetaObject RingApp::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_CLASSRingAppENDCLASS.offsetsAndSizes,
    qt_meta_data_CLASSRingAppENDCLASS,
    qt_static_metacall,
    nullptr,
    qt_metaTypeArray<
        // property 'useSystemAppBar'
        bool,
        // property 'windowIcon'
        QString,
        // property 'locale'
        QLocale,
        // Q_OBJECT / Q_GADGET
        RingApp,
        // method 'useSystemAppBarChanged'
        void,
        // method 'windowIconChanged'
        void,
        // method 'localeChanged'
        void,
        // method 'init'
        void,
        QObject *,
        QLocale,
        // method 'init'
        void,
        QObject *,
        // method 'iconDatas'
        QJsonArray,
        const QString &,
        // method 'iconDatas'
        QJsonArray
    >,
    nullptr
} };

void RingApp::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<RingApp *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->useSystemAppBarChanged(); break;
        case 1: _t->windowIconChanged(); break;
        case 2: _t->localeChanged(); break;
        case 3: _t->init((*reinterpret_cast< std::add_pointer_t<QObject*>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QLocale>>(_a[2]))); break;
        case 4: _t->init((*reinterpret_cast< std::add_pointer_t<QObject*>>(_a[1]))); break;
        case 5: { QJsonArray _r = _t->iconDatas((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])));
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 6: { QJsonArray _r = _t->iconDatas();
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (RingApp::*)();
            if (_t _q_method = &RingApp::useSystemAppBarChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (RingApp::*)();
            if (_t _q_method = &RingApp::windowIconChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (RingApp::*)();
            if (_t _q_method = &RingApp::localeChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 2;
                return;
            }
        }
    } else if (_c == QMetaObject::ReadProperty) {
        auto *_t = static_cast<RingApp *>(_o);
        (void)_t;
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< bool*>(_v) = _t->_useSystemAppBar; break;
        case 1: *reinterpret_cast< QString*>(_v) = _t->_windowIcon; break;
        case 2: *reinterpret_cast< QLocale*>(_v) = _t->_locale; break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        auto *_t = static_cast<RingApp *>(_o);
        (void)_t;
        void *_v = _a[0];
        switch (_id) {
        case 0:
            if (_t->_useSystemAppBar != *reinterpret_cast< bool*>(_v)) {
                _t->_useSystemAppBar = *reinterpret_cast< bool*>(_v);
                Q_EMIT _t->useSystemAppBarChanged();
            }
            break;
        case 1:
            if (_t->_windowIcon != *reinterpret_cast< QString*>(_v)) {
                _t->_windowIcon = *reinterpret_cast< QString*>(_v);
                Q_EMIT _t->windowIconChanged();
            }
            break;
        case 2:
            if (_t->_locale != *reinterpret_cast< QLocale*>(_v)) {
                _t->_locale = *reinterpret_cast< QLocale*>(_v);
                Q_EMIT _t->localeChanged();
            }
            break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    } else if (_c == QMetaObject::BindableProperty) {
    }
}

const QMetaObject *RingApp::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *RingApp::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_CLASSRingAppENDCLASS.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int RingApp::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 7)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 7;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 7)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 7;
    }else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 3;
    }
    return _id;
}

// SIGNAL 0
void RingApp::useSystemAppBarChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void RingApp::windowIconChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void RingApp::localeChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}
QT_WARNING_POP
