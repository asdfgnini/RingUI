#ifndef RINGSINGLE_H
#define RINGSINGLE_H

//创建一个单例类
template<typename T>
class RingSingle{
public:
    static T* getInstance();
};

template<typename T>
T* RingSingle<T>::getInstance()
{
    static T* instance = new T();
    return instance;
}

//创建一个用于创建单例类的宏函数，方便其他类调用
#define RINGSINGLE(Class)                        \
private:                                         \
    friend class RingSingle<Class>;              \
public:                                          \
    static Class* getInstance()                  \
    {                                            \
        return RingSingle<Class>::getInstance(); \
    }                                            \



#endif // RINGSINGLE_H
