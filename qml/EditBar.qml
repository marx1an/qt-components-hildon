import QtQuick 1.0
import "Utils.js" as Utils

Item {
    id: root

    property alias titleText: title.text
    default property alias buttons: buttonRow.children
    property Style platformStyle: Style {}

    height: 56
    anchors {
        top: !parent ? undefined : parent.top
        left: !parent ? undefined : parent.left
        right: !parent ? undefined : parent.right
        rightMargin: screen.inPortrait ? 70 : 112
    }

    Component.onCompleted: root.parent = Utils.findRootItem(root)

    Image {
        id: background

        anchors.fill: parent
        fillMode: Image.Stretch
        smooth: true
        source: "image://theme/wmTitleBar"
    }

    Label {
        id: title

        anchors {
            left: parent.left
            leftMargin: platformStyle.paddingNormal
            right: buttonRow.left
            rightMargin: platformStyle.paddingNormal
            verticalCenter: parent.verticalCenter
        }
        clip: true
    }

    Row {
        id: buttonRow

        spacing: platformStyle.paddingSmall
        anchors {
            right: parent.right
            rightMargin: platformStyle.paddingNormal
            verticalCenter: parent.verticalCenter
        }
    }

    MouseArea {
        z: -1
        anchors.fill: parent
    }
}
