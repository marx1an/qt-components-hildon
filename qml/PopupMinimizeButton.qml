import QtQuick 1.0

Item {
    id: root

    property bool enabled: true

    width: screen.inPortrait ? 70 : 112
    height: 56

    Image {
        id: background

        anchors.fill: parent
        source: "image://theme/wmLeftButtonEnd"
    }

    Image {
        id: separator

        anchors { top: parent.top; bottom: parent.bottom; right: parent.right }
        source: "image://theme/wmSeparator"
    }

    Image {
        id: icon

        anchors.centerIn: parent
        source: "image://theme/wmTaskSwitcherIcon"
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        enabled: root.enabled
        onClicked: screen.minimize()
    }

    states: State {
        name: "pressed"
        when: mouseArea.pressed
        PropertyChanges { target: background; source: "image://theme/wmLeftButtonEndPressed" }
        PropertyChanges { target: icon; source: "image://theme/wmTaskSwitcherIconPressed" }
    }
}
