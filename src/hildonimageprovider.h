#ifndef HILDONIMAGEPROVIDER_H
#define HILDONIMAGEPROVIDER_H

#include <QDeclarativeImageProvider>

class HildonImageProvider : public QDeclarativeImageProvider
{

public:
    explicit HildonImageProvider();
    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize);

private:
    QString getFileName(QString id);
};

#endif // HILDONIMAGEPROVIDER_H
