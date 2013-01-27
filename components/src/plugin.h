#include "hildonscreenplugin.h"
#include "hildonwindowplugin.h"
#include "hildonsystemplugin.h"
#include "hildonthemeplugin.h"
#include "hildonimageprovider.h"
#include "hildonenums.h"
#include "filesystemmodel.h"
#include "maskeditem.h"
#include "effects.h"
#include "qdeclarativeprocess.h"
#include "qdeclarativesettings.h"
#include <QtDeclarative>
#include <QApplication>

class HildonPlugin : public QDeclarativeExtensionPlugin
{
    Q_OBJECT

public:
    void initializeEngine(QDeclarativeEngine *engine, const char *uri) {
        Q_ASSERT(uri == QLatin1String("org.hildon.components"));

        QDeclarativeExtensionPlugin::initializeEngine(engine, uri);

        if(!engine->imageProvider(QLatin1String("theme"))) {
            engine->addImageProvider(QLatin1String("theme"), new HildonImageProvider);

            engine->rootContext()->setContextProperty("screen", new HildonScreenPlugin);
            qmlRegisterUncreatableType<HildonScreenPlugin>(uri, 1, 0, "Screen", "");

            engine->rootContext()->setContextProperty("platformWindow", new HildonWindowPlugin);
            qmlRegisterUncreatableType<HildonWindowPlugin>(uri, 1, 0, "PlatformWindow", "");

            engine->rootContext()->setContextProperty("theme", new HildonThemePlugin);
            qmlRegisterUncreatableType<HildonThemePlugin>(uri, 1, 0, "Theme", "");

            engine->rootContext()->setContextProperty("system", new HildonSystemPlugin);
            qmlRegisterUncreatableType<HildonSystemPlugin>(uri, 1, 0, "System", "");

            QApplication *app = qobject_cast<QApplication*>(QApplication::instance());

            if (app) {
                app->setCursorFlashTime(0);
            }            
        }
    }

    void registerTypes(const char *uri) {
        Q_ASSERT(uri == QLatin1String("org.hildon.components"));

        qmlRegisterUncreatableType<HildonValueLayout>(uri, 1, 0, "ValueLayout", "");
        qmlRegisterUncreatableType<HildonDialogStatus>(uri, 1, 0, "DialogStatus", "");
        qmlRegisterUncreatableType<HildonInputMode>(uri, 1, 0, "InputMode", "");
        qmlRegisterUncreatableType<HildonScreenOrientation>(uri, 1, 0, "ScreenOrientation", "");
        qmlRegisterUncreatableType<HildonNetworkMode>(uri, 1, 0, "NetworkMode", "");
        qmlRegisterUncreatableType<Desaturation>(uri, 1, 0, "Desaturation", "");
        qmlRegisterUncreatableType<QDeclarativeProcessEnums>(uri, 1, 0, "Processes", "");

        qmlRegisterType<FileSystemModel>(uri, 1, 0, "FileSystemModel");
        qmlRegisterType<MaskedItem>(uri, 1, 0, "MaskedItem");
        qmlRegisterType<BlurEffect>(uri, 1, 0, "BlurEffect");
        qmlRegisterType<DesaturateEffect>(uri, 1, 0, "DesaturateEffect");
        qmlRegisterType<QDeclarativeProcess>(uri, 1, 0, "Process");
        qmlRegisterType<QDeclarativeSettings>(uri, 1, 0, "Settings");
    }
};

Q_EXPORT_PLUGIN2(hildonplugin, HildonPlugin)
