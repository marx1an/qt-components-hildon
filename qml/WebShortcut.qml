import QtQuick 1.0

Image {
    id: root

    property alias thumbnail: thumbnail.source
    property alias text: label.text
    property url link

    signal clicked
    signal pressAndHold

    smooth: true
    source: "image://theme/WebShortcutAppletBackground"

    MaskedItem {
        z: -1
        width: 160
        height: 96
        anchors { left: parent.left; top: parent.top; margins: 8 }
        mask: Image {
            anchors.fill: parent
            source: "image://theme/WebShortCutAppletThumbnailMask"
            smooth: true
            fillMode: Image.Stretch
            clip: true
            asynchronous: true
        }

        Image {
            id: thumbnail

            anchors.fill: parent
            smooth: true
            fillMode: Image.PreserveAspectCrop
        }

    }

    Label {
        id: label

        anchors { left: parent.left; right: parent.right; bottom: parent.bottom; margins: 12 }
        font.pixelSize: 18
        color: "white"
        clip: true
        horizontalAlignment: paintedWidth < parent.width - 24 ? Text.AlignHCenter : Text.AlignLeft
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        onPressAndHold: root.pressAndHold()
        onClicked: {
            Qt.openUrlExternally(root.link);
            root.clicked();
        }
    }

    states: State {
        name: "pressed"
        when: mouseArea.pressed
        PropertyChanges { target: root; source: "image://theme/WebShortcutAppletBackgroundActive" }
    }
}
