#include "hildonimageprovider.h"
#include <QFileInfo>

HildonImageProvider::HildonImageProvider() :
    QDeclarativeImageProvider(QDeclarativeImageProvider::Image)
{
}

QString HildonImageProvider::getFileName(QString id) {
    QString fileName;

    if (id.startsWith("icon/")) {
        fileName = "/usr/share/icons/hicolor/48x48/hildon/" + id.section('/', -1).section('.', 0, 0);
    }
    else {
        fileName = "/etc/hildon/theme/images/" + id.section('.', 0, 0);
    }

    QFileInfo info(fileName + ".png");

    if (!info.exists()) {
        info.setFile(fileName + ".svg");
    }

    if (!info.exists()) {
        info.setFile(fileName + ".jpg");
    }

    return info.absoluteFilePath();
}

QImage HildonImageProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize) {
    QString fileName = this->getFileName(id);
    QImage image(fileName);

    if (!image.isNull()) {
        int width = image.width();
        int height = image.height();

        if (size) {
            *size = QSize(width, height);
        }

        if ((requestedSize.width() < width) || (requestedSize.height() < height)) {
            image.scaled(width, height);
        }
    }

    return image;
}
