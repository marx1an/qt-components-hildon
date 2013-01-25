#include "hildonscreenplugin.h"
#include <QApplication>
#include <QDeclarativeItem>

HildonScreenPlugin::HildonScreenPlugin(QDeclarativeItem *parent) :
    QObject(parent),
    m_display(QApplication::desktop())
{
    this->connect(m_display, SIGNAL(resized(int)), this, SIGNAL(orientationChanged()));
}
