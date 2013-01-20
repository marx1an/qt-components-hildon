#include "hildonwindowplugin.h"
#include <QtDBus/QDBusConnection>
#include <QtDBus/QDBusMessage>
#include <QtDBus/QDBusInterface>
#include <QApplication>
#include <QDeclarativeView>
#include <QDebug>

HildonWindowPlugin::HildonWindowPlugin(QDeclarativeItem *parent) :
    QObject(parent)
{
}

void HildonWindowPlugin::minimize() {
    QDBusConnection bus = QDBusConnection::sessionBus();

    QDBusMessage message = QDBusMessage::createSignal("/", "com.nokia.hildon_desktop", "exit_app_view");
    bus.send(message);
}

void HildonWindowPlugin::activate() {
    QDeclarativeView *view = qobject_cast<QDeclarativeView*>(QApplication::activeWindow());

    if (!view) {
        qWarning() << "No active window. Cannot activate";
        return;
    }

    view->activateWindow();
}

void HildonWindowPlugin::setScreenOrientation(int orientation) {
    QDeclarativeView *view = qobject_cast<QDeclarativeView*>(QApplication::activeWindow());

    if (!view) {
        qWarning() << "No active window. Cannot set screen orientation";
        return;
    }

    m_orientation = static_cast<HildonScreenOrientation::ScreenOrientation>(orientation);

    Qt::WidgetAttribute attribute;

    switch (m_orientation) {

#if QT_VERSION < 0x040702
    // Qt < 4.7.2 does not yet have the Qt::WA_*Orientation attributes
    case HildonScreenOrientation::LockPortrait:
        attribute = static_cast<Qt::WidgetAttribute>(128);
        break;
    case HildonScreenOrientation::LockLandscape:
        attribute = static_cast<Qt::WidgetAttribute>(129);
        break;
    default:
    case HildonScreenOrientation::Automatic:
        attribute = static_cast<Qt::WidgetAttribute>(130);
        break;
#else // QT_VERSION < 0x040702
    case HildonScreenOrientation::LockPortrait:
        attribute = Qt::WA_LockPortraitOrientation;
        break;
    case HildonScreenOrientation::LockLandscape:
        attribute = Qt::WA_LockLandscapeOrientation;
        break;
    default:
    case HildonScreenOrientation::Automatic:
        attribute = Qt::WA_AutoOrientation;
        break;
#endif // QT_VERSION < 0x040702

    };

    view->setAttribute(attribute, true);
    emit screenOrientationChanged();
}
