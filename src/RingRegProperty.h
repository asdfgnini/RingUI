#ifndef RINGREGPROPERTY_H
#define RINGREGPROPERTY_H

//向QML中注册一个属性，属性的值通过值拷贝传递
#define Q_PROPERTY_AUTO_P(TYPE, M)                                                                                   \
Q_PROPERTY(TYPE M MEMBER _##M NOTIFY M##Changed)                                                                     \
public:                                                                                                              \
    Q_SIGNAL void M##Changed();                                                                                      \
    void M(TYPE in_##M)                                                                                              \
    {                                                                                                                \
        _##M = in_##M;                                                                                               \
        Q_EMIT M##Changed();                                                                                         \
    }                                                                                                                \
    TYPE M()                                                                                                         \
    {                                                                                                                \
        return _##M;                                                                                                 \
    }                                                                                                                \
private:                                                                                                             \
    TYPE _##M;


//向QML中注册一个属性，属性的值通过常量引用传递
#define Q_PROPERTY_AUTO(TYPE, M)                                                                                     \
Q_PROPERTY(TYPE M MEMBER _##M NOTIFY M##Changed)                                                                     \
public:                                                                                                              \
    Q_SIGNAL void M##Changed();                                                                                      \
    void M(const TYPE& in_##M)                                                                                       \
    {                                                                                                                \
        _##M = in_##M;                                                                                               \
        Q_EMIT M##Changed();                                                                                         \
    }                                                                                                                \
    TYPE M()                                                                                                         \
    {                                                                                                                \
        return _##M;                                                                                                 \
    }                                                                                                                \
private:                                                                                                             \
    TYPE _##M;

//向QML中注册一个制度属性，对于QML来说这个属性只可读
#define Q_PROPERTY_READONLY_AUTO(TYPE, M)                                                                            \
Q_PROPERTY(TYPE M READ M NOTIFY M##Changed FINAL)                                                                    \
public:                                                                                                              \
    Q_SIGNAL void M##Changed();                                                                                      \
    void M(const TYPE& in_##M)                                                                                       \
    {                                                                                                                \
        _##M = in_##M;                                                                                               \
        Q_EMIT M##Changed();                                                                                         \
    }                                                                                                                \
    TYPE M()                                                                                                         \
    {                                                                                                                \
        return _##M;                                                                                                 \
    }                                                                                                                \
private:                                                                                                             \
    TYPE _##M;



#endif // RINGREGPROPERTY_H
