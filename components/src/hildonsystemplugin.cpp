#include "hildonsystemplugin.h"
#include <QTimer>
#include <QDeclarativeItem>

HildonSystemPlugin::HildonSystemPlugin(QDeclarativeItem *parent) :
    QObject(parent),
    m_device(new QSystemDeviceInfo(parent)),
    m_network(new QSystemNetworkInfo(parent))
{
    this->connect(m_device, SIGNAL(batteryLevelChanged(int)), this, SIGNAL(batteryLevelChanged()));
    this->connect(m_device, SIGNAL(currentProfileChanged(QSystemDeviceInfo::Profile)), this, SIGNAL(profileChanged()));
    this->connect(m_network, SIGNAL(networkModeChanged(QSystemNetworkInfo::NetworkMode)), this, SIGNAL(networkModeChanged()));

    QTimer timer;
    timer.setInterval(30000);
    timer.setSingleShot(false);
    timer.start();
    this->connect(&timer, SIGNAL(timeout()), this, SIGNAL(currentTimeStringChanged()));
}
