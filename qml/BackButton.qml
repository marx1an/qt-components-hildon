import QtQuick 1.0

Item {
    id: root

    property alias pressed: mouseArea.pressed
    property alias iconSource: icon.source

    signal pressAndHold
    signal clicked

    width: screen.inPortrait ? 70 : 112
    height: 56

    Image {
        id: background

        anchors.fill: parent
        source: "image://theme/wmRightButtonPressed"
        visible: mouseArea.pressed
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
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        onPressAndHold: root.pressAndHold()
        onClicked: root.clicked()
    }
}
