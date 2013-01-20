#include "hildonscreenplugin.h"
#include <QApplication>

HildonScreenPlugin::HildonScreenPlugin(QDeclarativeItem *parent) :
    QObject(parent),
    m_display(QApplication::desktop())
{
    connect(m_display, SIGNAL(resized(int)), this, SIGNAL(orientationChanged()));
}
