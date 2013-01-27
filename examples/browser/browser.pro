TARGET = qt-components-hildon-browser

QT += xml

# Add more folders to ship with the application, here
folder_01.source = qml/browser
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

SOURCES += main.cpp \
    bookmarksmodel.cpp

HEADERS += \
    bookmarksmodel.h

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    qtc_packaging/debian_fremantle/rules \
    qtc_packaging/debian_fremantle/README \
    qtc_packaging/debian_fremantle/copyright \
    qtc_packaging/debian_fremantle/control \
    qtc_packaging/debian_fremantle/compat \
    qtc_packaging/debian_fremantle/changelog
