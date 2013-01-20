import QtQuick 1.0

Item {
    id: root

    property bool enabled: true

    signal pressAndHold
    signal clicked

    width: screen.inPortrait ? 70 : 112
    height: 56

    Image {
        id: background

        anchors.fill: parent
        source: "image://theme/wmRightButtonPressed"
        visible: false
    }

    Image {
        id: separator

        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
        }
        source: "image://theme/wmSeparator"
    }

    Image {
        id: icon

        anchors.centerIn: parent
        source: (pageStack == null) || (pageStack.depth == 1) ? "image://theme/wmCloseIcon" + root.state :
                                                                "image://theme/wmBackIcon" + root.state
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        enabled: root.enabled
        onPressAndHold: root.pressAndHold()
        onClicked: root.clicked()
    }

    states: State {
        name: "Pressed"
        when: mouseArea.pressed
        PropertyChanges { target: background; visible: true }
    }
}
