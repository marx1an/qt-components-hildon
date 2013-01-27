#ifndef QDECLARATIVESETTINGS_H
#define QDECLARATIVESETTINGS_H

#include <QObject>
#include <QVariant>
#include <QString>
#include <QDeclarativeParserStatus>

class QDeclarativeItem;
class QSettings;

class QDeclarativeSettings : public QObject, public QDeclarativeParserStatus
{
    Q_OBJECT

    Q_INTERFACES(QDeclarativeParserStatus)

    Q_PROPERTY(QString organizationName
               READ organizationName
               WRITE setOrganizationName)
    Q_PROPERTY(QString applicationName
               READ applicationName
               WRITE setApplicationName)
    Q_PROPERTY(QString fileName
               READ fileName
               WRITE setFileName)

public:
    explicit QDeclarativeSettings(QDeclarativeItem *parent = 0);
    Q_INVOKABLE QVariant value(const QString &key, const QVariant &defaultValue = QVariant()) const;
    Q_INVOKABLE void setValue(const QString &key, const QVariant &value);
    Q_INVOKABLE void remove(const QString &key);
    inline QString organizationName() const { return m_organizationName; }
    void setOrganizationName(const QString &name);
    inline QString applicationName() const { return m_applicationName; }
    void setApplicationName(const QString &name);
    inline QString fileName() const { return m_fileName; }
    void setFileName(const QString &name);
    void classBegin();
    void componentComplete();
    
signals:
    void valueChanged(const QString &key, const QVariant &value);

private:
    QString m_organizationName;
    QString m_applicationName;
    QString m_fileName;
    QSettings *m_settings;
};

#endif // QDECLARATIVESETTINGS_H
