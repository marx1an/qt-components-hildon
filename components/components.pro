TEMPLATE = lib
TARGET = $$qtLibraryTarget(hildonplugin)

QT += declarative dbus
CONFIG += qt plugin copy_native install_native mobility
MOBILITY += systeminfo

qml_files.files += $$files(qml/*)
qml_files.path = /opt/lib/qt4/imports/org/hildon/components
target.path = /opt/lib/qt4/imports/org/hildon/components

OTHER_FILES += qtc_packaging/debian_fremantle/rules \
    qtc_packaging/debian_fremantle/README \
    qtc_packaging/debian_fremantle/copyright \
    qtc_packaging/debian_fremantle/control \
    qtc_packaging/debian_fremantle/compat \
    qtc_packaging/debian_fremantle/changelog \
    qtc_packaging/debian_fremantle/postinst \
    qml/InputDialog.qml \
    qml/InputDialogStyle.qml

SOURCES += src/fileinfothread.cpp \
    src/qdeclarativefolderlistmodel.cpp \
    src/filesystemmodel.cpp \
    src/hildonscreenplugin.cpp \
    src/hildonsystemplugin.cpp \
    src/maskeditem.cpp \
    src/maskeffect.cpp \
    src/effects.cpp \
    src/hildonwindowplugin.cpp \
    src/qdeclarativeprocess.cpp

HEADERS += src/fileinfothread_p.h \
    src/fileproperty_p.h \
    src/qdeclarativefolderlistmodel.h \
    src/filesystemmodel.h \
    src/hildonimageprovider.h \
    src/hildonscreenplugin.h \
    src/hildonsystemplugin.h \
    src/hildonthemeplugin.h \
    src/maskeditem.h \
    src/maskeffect.h \
    src/effects.h \
    src/hildonenums.h \
    src/hildonwindowplugin.h \
    src/qdeclarativeprocess.h \
    src/plugin.h

maemo5 {
    SOURCES += src/hildonthemeplugin.cpp \
        src/hildonimageprovider.cpp
}
else {
    SOURCES += src/test/hildonthemeplugin.cpp \
        src/test/hildonimageprovider.cpp
}

INSTALLS += target qml_files

