import QtQuick 1.0

MouseArea {
    property real globalX: !globalPos ? 0 : globalPos.x
    property real globalY: !globalPos ? 0 : globalPos.y
    property variant globalPos

    signal globalClicked(real globalX, real globalY)
    signal globalPressAndHold(real globalX, real globalY)

    objectName: "__mouseArea"
    onPositionChanged: globalPos = mapToItem(null, mouseX, mouseY)
    onClicked: globalClicked(globalX, globalY)
    onPressAndHold: globalPressAndHold(globalX, globalY)
}
