#include "effects.h"

BlurEffect::BlurEffect(QObject *parent) :
    QGraphicsBlurEffect(parent)
{
}

void BlurEffect::setBlurRadius(qreal blurRadius) {
    QGraphicsBlurEffect::setBlurRadius(blurRadius);
    emit blurRadiusChanged();
}

DesaturateEffect::DesaturateEffect(QObject *parent) :
    QGraphicsColorizeEffect(parent)
{
    setColor(QColor(0, 0, 0, 0));
}

void DesaturateEffect::setColor(const QColor &c) {
    QGraphicsColorizeEffect::setColor(c);
    emit colorChanged();
}
