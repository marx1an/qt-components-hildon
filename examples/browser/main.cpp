#include <QtGui/QApplication>
#include <qdeclarative.h>
#include "qmlapplicationviewer.h"
#include "bookmarksmodel.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    qmlRegisterType<BookmarksModel>("org.hildon.browser",1,0,"BookmarksModel");

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/browser/main.qml"));
    viewer.showExpanded();

    return app->exec();
}
