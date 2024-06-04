#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "CircularReveal.h"


int main(int argc, char *argv[])
{
    const char *uri = "example";
    int major = 1;
    int minor = 0;

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterType<CircularReveal>(uri, major, minor, "CircularReveal");


    const QUrl url(QStringLiteral("qrc:/example/qml/main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
