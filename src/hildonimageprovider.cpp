#include "hildonimageprovider.h"
#include <QFileInfo>

HildonImageProvider::HildonImageProvider() :
    QDeclarativeImageProvider(QDeclarativeImageProvider::Image)
{
}

QString HildonImageProvider::getFileName(QString id) {
    QString fileName;

#ifdef Q_WS_MAEMO_5
    if (id.startsWith("icon/")) {
        fileName = "/usr/share/icons/hicolor/48x48/hildon/" + id.section('/', -1).section('.', 0, 0);
    }
    else {
        fileName = "/etc/hildon/theme/images/" + id.section('.', 0, 0);
    }
#else
    if (id.startsWith("icon/")) {
        fileName = "/home/stuart/Development/QtProjects/Maemo5_Theme/icons/hildon/" + id.section('/', -1).section('.', 0, 0);
    }
    else {
        fileName = "/home/stuart/Development/QtProjects/Maemo5_Theme/images/" + id.section('.', 0, 0);
    }
#endif

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
    QString fileName = getFileName(id);
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
