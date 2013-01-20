#ifndef HILDONSCREENPLUGIN_H
#define HILDONSCREENPLUGIN_H

#include <QObject>
#include <QDeclarativeItem>
#include <QDesktopWidget>

class HildonScreenPlugin : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int width
               READ width
               NOTIFY orientationChanged)
    Q_PROPERTY(int height
               READ height
               NOTIFY orientationChanged)
    Q_PROPERTY(bool inLandscape
               READ inLandscape
               NOTIFY orientationChanged)
    Q_PROPERTY(bool inPortrait
               READ inPortrait
               NOTIFY orientationChanged)

public:
    explicit HildonScreenPlugin(QDeclarativeItem *parent = 0);
    inline int width() const { return m_display->screenGeometry().width(); }
    inline int height() const { return m_display->screenGeometry().height(); }
    inline bool inLandscape() const { return width() > height(); }
    inline bool inPortrait() const { return !inLandscape(); }

signals:
    void orientationChanged();

private:
    QDesktopWidget *m_display;
};

#endif // HILDONSCREENPLUGIN_H
