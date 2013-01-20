#include "hildonsystemplugin.h"
#include <QTimer>

HildonSystemPlugin::HildonSystemPlugin(QDeclarativeItem *parent) :
    QObject(parent), m_device(new QSystemDeviceInfo(parent)), m_network(new QSystemNetworkInfo(parent))
{
    connect(m_device, SIGNAL(batteryLevelChanged(int)), this, SIGNAL(batteryLevelChanged()));
    connect(m_device, SIGNAL(currentProfileChanged(QSystemDeviceInfo::Profile)), this, SIGNAL(profileChanged()));
    connect(m_network, SIGNAL(networkModeChanged(QSystemNetworkInfo::NetworkMode)), this, SIGNAL(networkModeChanged()));

    QTimer timer;
    timer.setInterval(30000);
    timer.setSingleShot(false);
    timer.start();
    connect(&timer, SIGNAL(timeout()), this, SIGNAL(currentTimeStringChanged()));
}
