import QtQuick 1.0

ListView {
    objectName: "__listView"
    interactive: visibleArea.heightRatio < 1
    currentIndex: -1
}
