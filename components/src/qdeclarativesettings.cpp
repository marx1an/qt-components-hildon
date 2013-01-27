#include "qdeclarativesettings.h"
#include <QDeclarativeItem>
#include <QSettings>
#include <QDebug>

QDeclarativeSettings::QDeclarativeSettings(QDeclarativeItem *parent) :
    QObject(parent),
    m_settings(0)
{
}

QVariant QDeclarativeSettings::value(const QString &key, const QVariant &defaultValue) const {
    if (m_settings) {
        return m_settings->value(key, defaultValue);
    }
    else {
        qWarning() << "Settings not initialized";
        return QVariant();
    }
}

void QDeclarativeSettings::setValue(const QString &key, const QVariant &value) {
    if (this->value(key) != value) {
        if (m_settings) {
            m_settings->setValue(key, value);
            emit valueChanged(key, value);
        }
        else {
            qWarning() << "Settings not initialized";
        }
    }
}

void QDeclarativeSettings::remove(const QString &key) {
    if (m_settings) {
        m_settings->remove(key);
    }
    else {
        qWarning() << "Settings not initialized";
    }
}

void QDeclarativeSettings::setOrganizationName(const QString &name) {
    if (this->organizationName().isEmpty()) {
        m_organizationName = name;
    }
    else {
        qWarning() << "organizationName cannot be changed once set";
    }
}

void QDeclarativeSettings::setApplicationName(const QString &name) {
    if (this->applicationName().isEmpty()) {
        m_applicationName = name;
    }
    else {
        qWarning() << "applicationName cannot be changed once set";
    }
}

void QDeclarativeSettings::setFileName(const QString &name) {
    if (this->fileName().isEmpty()) {
        m_fileName = name;
    }
    else {
        qWarning() << "fileName cannot be changed once set";
    }
}

void QDeclarativeSettings::classBegin() {}

void QDeclarativeSettings::componentComplete() {
    if (!this->fileName().isEmpty()) {
        m_settings = new QSettings(this->fileName(), QSettings::IniFormat, this);
    }
    else {
        m_settings = new QSettings(this->organizationName(), this->applicationName(), this);
    }
}
