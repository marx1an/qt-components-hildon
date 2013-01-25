#include <QtGui/QApplication>
#include <QDeclarativeContext>
#include <QtDeclarative>
#include "qmlapplicationviewer.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QmlApplicationViewer viewer;
    viewer.setMainQmlFile(QLatin1String("qml/gallery/main.qml"));
    viewer.showFullScreen();

    return app.exec();
}
