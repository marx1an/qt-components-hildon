#ifndef HILDONSYSTEMPLUGIN_H
#define HILDONSYSTEMPLUGIN_H

#include "hildonenums.h"
#include <QObject>
#include <QDeclarativeItem>
#include <QSystemDeviceInfo>
#include <QSystemNetworkInfo>
#include <QTime>

using namespace QtMobility;

class HildonSystemPlugin : public QObject
{
    Q_OBJECT

    Q_ENUMS(NetworkMode)

    Q_PROPERTY(int batteryLevel
               READ batteryLevel
               NOTIFY batteryLevelChanged)
    Q_PROPERTY(bool silentProfile
               READ silentProfile
               NOTIFY profileChanged)
    Q_PROPERTY(bool simAvailable
               READ simAvailable
               CONSTANT)
    Q_PROPERTY(HildonNetworkMode::NetworkMode networkMode
               READ networkMode
               NOTIFY networkModeChanged)
    Q_PROPERTY(QString currentTimeString
               READ currentTimeString
               NOTIFY currentTimeStringChanged)

public:
    explicit HildonSystemPlugin(QDeclarativeItem *parent = 0);
    inline int batteryLevel() const { return m_device->batteryLevel(); }
    inline bool silentProfile() const { return m_device->currentProfile() == QSystemDeviceInfo::SilentProfile; }
    inline bool simAvailable() const { return m_device->simStatus() != QSystemDeviceInfo::SimNotAvailable; }
    inline HildonNetworkMode::NetworkMode networkMode() const { return HildonNetworkMode::NetworkMode(m_network->currentMode()); }
    inline QString currentTimeString() const { return QTime::currentTime().toString("h:mm ap"); }

signals:
    void batteryLevelChanged();
    void profileChanged();
    void networkModeChanged();
    void currentTimeStringChanged();
    
private:
    QSystemDeviceInfo *m_device;
    QSystemNetworkInfo *m_network;
};

#endif // HILDONSYSTEMPLUGIN_H
