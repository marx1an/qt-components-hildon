import QtQuick 1.0

Flickable {
    objectName: "__flickable"
    interactive: (visibleArea.widthRatio < 1) || (visibleArea.heightRatio < 1)
}
