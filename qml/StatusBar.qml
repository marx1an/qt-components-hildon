import QtQuick 1.0

Item {
    id: root

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
        onClicked: menu.open()
    }

    BackButton {
        id: backButton

        anchors { top: parent.top; right: parent.right }
        onClicked: pageStack.depth == 1 ? Qt.quit() : pageStack.pop()
        onPressAndHold: if (pageStack.depth > 1) pageStack.pop(null);
    }
}
