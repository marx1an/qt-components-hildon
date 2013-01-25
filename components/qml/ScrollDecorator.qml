import QtQuick 1.0

Item {
    id: root

    property Flickable flickableItem

    anchors.fill: !flickableItem ? undefined : flickableItem
    clip: true

    Rectangle {
        anchors.right: parent.right
        y: !flickableItem ? 0 : flickableItem.visibleArea.yPosition * flickableItem.height
        width: 10
        height: !flickableItem ? 0 : flickableItem.visibleArea.heightRatio * flickableItem.height
        opacity: !flickableItem ? 0 : flickableItem.movingVertically ? 1 : 0
        color: "#aba4a2"

        Behavior on opacity { NumberAnimation { duration: 300 } }
    }

    Rectangle {
        anchors.bottom: parent.bottom
        x: !flickableItem ? 0 : flickableItem.visibleArea.xPosition * flickableItem.width
        height: 10
        width: !flickableItem ? 0 : flickableItem.visibleArea.widthRatio * flickableItem.width
        opacity: !flickableItem ? 0 : flickableItem.movingHorizontally ? 1 : 0
        color: "#aba4a2"

        Behavior on opacity { NumberAnimation { duration: 300 } }
    }
}


