#ifndef HILDONWINDOWPLUGIN_H
#define HILDONWINDOWPLUGIN_H

#include "hildonenums.h"
#include <QObject>
#include <QDeclarativeItem>

class HildonWindowPlugin : public QObject
{
    Q_OBJECT

    Q_PROPERTY(HildonScreenOrientation::ScreenOrientation screenOrientation
               READ screenOrientation
               WRITE setScreenOrientation
               NOTIFY screenOrientationChanged)

public:
    explicit HildonWindowPlugin(QDeclarativeItem *parent = 0);
    inline HildonScreenOrientation::ScreenOrientation screenOrientation() const { return m_orientation; }
    void setScreenOrientation(int orientation);
    Q_INVOKABLE void minimize();
    Q_INVOKABLE void activate();
    
signals:
    void screenOrientationChanged();

private:
    HildonScreenOrientation::ScreenOrientation m_orientation;
};

#endif // HILDONWINDOWPLUGIN_H
