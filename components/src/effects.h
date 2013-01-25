#ifndef EFFECTS_H
#define EFFECTS_H

#include <QGraphicsBlurEffect>
#include <QGraphicsColorizeEffect>

class BlurEffect : public QGraphicsBlurEffect
{
    Q_OBJECT

    Q_PROPERTY(qreal blurRadius
               READ blurRadius
               WRITE setBlurRadius
               NOTIFY blurRadiusChanged)

public:
    explicit BlurEffect(QObject *parent = 0);
    void setBlurRadius(qreal blurRadius);
    
signals:
    void blurRadiusChanged();
};

class DesaturateEffect : public QGraphicsColorizeEffect
{
    Q_OBJECT

    Q_PROPERTY(QColor color
               READ color
               WRITE setColor
               NOTIFY colorChanged)

public:
    explicit DesaturateEffect(QObject *parent = 0);
    void setColor(const QColor &c);

signals:
    void colorChanged();
};

#endif // EFFECTS_H
