import QtQuick 1.0

Item {
    id: root

    property alias showMenuIndicator: titleArea.showMenuIndicator
    property alias showBusyIndicator: titleArea.showBusyIndicator
    property alias backButtonIconSource: backButton.iconSource
    property alias backButtonPressed: backButton.pressed
    property alias titleText: titleArea.title

    signal titleAreaClicked
    signal backClicked
    signal backPressAndHold

    height: 56
    anchors { top: parent.top; left: parent.left; right: parent.right }

    Image {
        id: background

        anchors.fill: parent
        fillMode: Image.Stretch
        smooth: true
        source: "image://theme/wmTitleBar"
    }

    MinimizeButton {
        id: minimizeButton

        anchors { top: parent.top; left: parent.left }
    }

    StatusArea {
        id: statusArea

        anchors { top: parent.top; left: minimizeButton.right }
    }

    TitleArea {
        id: titleArea

        anchors { top: parent.top; left: statusArea.right; right: backButton.left }
        onClicked: root.titleAreaClicked()
    }

    BackButton {
        id: backButton

        anchors { top: parent.top; right: parent.right }
        onClicked: root.backClicked()
        onPressAndHold: root.backPressAndHold()
    }
}
