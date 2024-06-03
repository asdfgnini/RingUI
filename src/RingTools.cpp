#include "RingTools.h"

#include <QGuiApplication>
#include <QClipboard>
#include <QUuid>
#include <QCursor>
#include <QScreen>
#include <QColor>
#include <QFileInfo>
#include <QProcess>
#include <QDir>
#include <QOpenGLContext>
#include <QCryptographicHash>
#include <QTextDocument>
#include <QQuickWindow>
#include <QDateTime>
#include <QSettings>

#ifdef Q_OS_WIN
#pragma comment (lib, "user32.lib")

#include <windows.h>
#include <windowsx.h>

#endif

RingTools::RingTools(QObject *parent) : QObject{parent} {

}

void RingTools::clipText(const QString &text) {
    QGuiApplication::clipboard()->setText(text);
}

QString RingTools::uuid() {
    return QUuid::createUuid().toString().remove('-').remove('{').remove('}');
}

QString RingTools::readFile(const QString &fileName) {
    QString content;
    QFile file(fileName);
    if (file.open(QIODevice::ReadOnly)) {
        QTextStream stream(&file);
        content = stream.readAll();
    }
    return content;
}

bool RingTools::isMacos() {
#if defined(Q_OS_MACOS)
    return true;
#else
    return false;
#endif
}

bool RingTools::isLinux() {
#if defined(Q_OS_LINUX)
    return true;
#else
    return false;
#endif
}

bool RingTools::isWin() {
#if defined(Q_OS_WIN)
    return true;
#else
    return false;
#endif
}

int RingTools::qtMajor() {
    const QString qtVersion = QString::fromLatin1(qVersion());
    const QStringList versionParts = qtVersion.split('.');
    return versionParts[0].toInt();
}

int RingTools::qtMinor() {
    const QString qtVersion = QString::fromLatin1(qVersion());
    const QStringList versionParts = qtVersion.split('.');
    return versionParts[1].toInt();
}

void RingTools::setQuitOnLastWindowClosed(bool val) {
    QGuiApplication::setQuitOnLastWindowClosed(val);
}

void RingTools::setOverrideCursor(Qt::CursorShape shape) {
    QGuiApplication::setOverrideCursor(QCursor(shape));
}

void RingTools::restoreOverrideCursor() {
    QGuiApplication::restoreOverrideCursor();
}

void RingTools::deleteLater(QObject *p) {
    if (p) {
        p->deleteLater();
    }
}

QString RingTools::toLocalPath(const QUrl &url) {
    return url.toLocalFile();
}

QString RingTools::getFileNameByUrl(const QUrl &url) {
    return QFileInfo(url.toLocalFile()).fileName();
}

QString RingTools::html2PlantText(const QString &html) {
    QTextDocument textDocument;
    textDocument.setHtml(html);
    return textDocument.toPlainText();
}

QRect RingTools::getVirtualGeometry() {
    return QGuiApplication::primaryScreen()->virtualGeometry();
}

QString RingTools::getApplicationDirPath() {
    return QGuiApplication::applicationDirPath();
}

QUrl RingTools::getUrlByFilePath(const QString &path) {
    return QUrl::fromLocalFile(path);
}

QColor RingTools::withOpacity(const QColor &color, qreal opacity) {
    int alpha = qRound(opacity * 255) & 0xff;
    return QColor::fromRgba((alpha << 24) | (color.rgba() & 0xffffff));
}

QString RingTools::md5(const QString &text) {
    return QCryptographicHash::hash(text.toUtf8(), QCryptographicHash::Md5).toHex();
}

QString RingTools::toBase64(const QString &text) {
    return text.toUtf8().toBase64();
}

QString RingTools::fromBase64(const QString &text) {
    return QByteArray::fromBase64(text.toUtf8());
}

bool RingTools::removeDir(const QString &dirPath) {
    QDir qDir(dirPath);
    return qDir.removeRecursively();
}

bool RingTools::removeFile(const QString &filePath) {
    QFile file(filePath);
    return file.remove();
}

QString RingTools::sha256(const QString &text) {
    return QCryptographicHash::hash(text.toUtf8(), QCryptographicHash::Sha256).toHex();
}

void RingTools::showFileInFolder(const QString &path) {
#if defined(Q_OS_WIN)
    QProcess::startDetached("explorer.exe", {"/select,", QDir::toNativeSeparators(path)});
#endif
#if defined(Q_OS_LINUX)
    QFileInfo fileInfo(path);
    auto process = "xdg-open";
    auto arguments = { fileInfo.absoluteDir().absolutePath() };
    QProcess::startDetached(process, arguments);
#endif
#if defined(Q_OS_MACOS)
    QProcess::execute("/usr/bin/osascript", {"-e", "tell application \"Finder\" to reveal POSIX file \"" + path + "\""});
    QProcess::execute("/usr/bin/osascript", {"-e", "tell application \"Finder\" to activate"});
#endif
}

bool RingTools::isSoftware() {
    return QQuickWindow::sceneGraphBackend() == "software";
}

QPoint RingTools::cursorPos() {
    return QCursor::pos();
}

qint64 RingTools::currentTimestamp() {
    return QDateTime::currentMSecsSinceEpoch();
}

QIcon RingTools::windowIcon() {
    return QGuiApplication::windowIcon();
}

int RingTools::cursorScreenIndex() {
    int screenIndex = 0;
    int screenCount = QGuiApplication::screens().count();
    if (screenCount > 1) {
        QPoint pos = QCursor::pos();
        for (int i = 0; i <= screenCount - 1; ++i) {
            if (QGuiApplication::screens().at(i)->geometry().contains(pos)) {
                screenIndex = i;
                break;
            }
        }
    }
    return screenIndex;
}

int RingTools::windowBuildNumber() {
#if defined(Q_OS_WIN)
    QSettings regKey{QString::fromUtf8(R"(HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion)"), QSettings::NativeFormat};
    if (regKey.contains(QString::fromUtf8("CurrentBuildNumber"))) {
        auto buildNumber = regKey.value(QString::fromUtf8("CurrentBuildNumber")).toInt();
        return buildNumber;
    }
#endif
    return -1;
}

bool RingTools::isWindows11OrGreater() {
    static QVariant var;
    if (var.isNull()) {
#if defined(Q_OS_WIN)
        auto buildNumber = windowBuildNumber();
        if (buildNumber >= 22000) {
            var = QVariant::fromValue(true);
            return true;
        }
#endif
        var = QVariant::fromValue(false);
        return false;
    } else {
        return var.toBool();
    }
}

bool RingTools::isWindows10OrGreater() {
    static QVariant var;
    if (var.isNull()) {
#if defined(Q_OS_WIN)
        auto buildNumber = windowBuildNumber();
        if (buildNumber >= 10240) {
            var = QVariant::fromValue(true);
            return true;
        }
#endif
        var = QVariant::fromValue(false);
        return false;
    } else {
        return var.toBool();
    }
}

QRect RingTools::desktopAvailableGeometry(QQuickWindow *window) {
    return window->screen()->availableGeometry();
}

QString RingTools::getWallpaperFilePath() {
#if defined(Q_OS_WIN)
    wchar_t path[MAX_PATH] = {};
    if (::SystemParametersInfoW(SPI_GETDESKWALLPAPER, MAX_PATH, path, FALSE) == FALSE) {
        return {};
    }
    return QString::fromWCharArray(path);
#elif defined(Q_OS_LINUX)
    auto type = QSysInfo::productType();
    if (type == "uos") {
        QProcess process;
        QStringList args;
        args << "--session";
        args << "--type=method_call";
        args << "--print-reply";
        args << "--dest=com.deepin.wm";
        args << "/com/deepin/wm";
        args << "com.deepin.wm.GetCurrentWorkspaceBackgroundForMonitor";
        args << QString("string:'%1'").arg(currentTimestamp());
        process.start("dbus-send", args);
        process.waitForFinished();
        QByteArray result = process.readAllStandardOutput().trimmed();
        int startIndex = result.indexOf("file:///");
        if (startIndex != -1) {
            auto path = result.mid(startIndex + 7, result.length() - startIndex - 8);
            return path;
        }
    }
#elif defined(Q_OS_MACOS)
    QProcess process;
    QStringList args;
    args << "-e";
    args << R"(tell application "Finder" to get POSIX path of (desktop picture as alias))";
    process.start("osascript", args);
    process.waitForFinished();
    QByteArray result = process.readAllStandardOutput().trimmed();
    if(result.isEmpty()){
        return "/System/Library/CoreServices/DefaultDesktop.heic";
    }
    return result;
#else
    return {};
#endif
}

QColor RingTools::imageMainColor(const QImage &image, double bright) {
    int step = 20;
    int t = 0;
    int r = 0, g = 0, b = 0;
    for (int i = 0; i < image.width(); i += step) {
        for (int j = 0; j < image.height(); j += step) {
            if (image.valid(i, j)) {
                t++;
                QColor c = image.pixel(i, j);
                r += c.red();
                b += c.blue();
                g += c.green();
            }
        }
    }
    return QColor(int(bright * r / t) > 255 ? 255 : int(bright * r / t), int(bright * g / t) > 255 ? 255 : int(bright * g / t), int(bright * b / t) > 255 ? 255 : int(bright * b / t));
}
