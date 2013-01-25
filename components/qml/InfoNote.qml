import QtQuick 1.0

Popup {
    id: root

    property alias content: content.children
    property bool interactive: true
    property string __portraitString: screen.inPortrait ? "Portrait" : ""
    property Style platformStyle: Style {}

    signal clicked

    z: -1
    width: screen.width
    height: background.height
    anchors.verticalCenter: parent.verticalCenter
    objectName: "__infoNote"
    modal: false
    onClicked: close()

    Image {
        id: background

        height: Math.max(150, content.height + platformStyle.paddingLarge * 2)
        anchors { left: parent.left; right: parent.right; verticalCenter: parent.verticalCenter }
        source: "image://theme/wmBanner" + root.__portraitString
        fillMode: Image.Stretch
        smooth: true
        opacity: theme.infoNoteOpacity
    }

    Item {
        id: content

        height: childrenRect.height
        anchors { left: parent.left; leftMargin: platformStyle.paddingLarge; right: parent.right; rightMargin: platformStyle.paddingLarge; verticalCenter: parent.verticalCenter }
    }

    MouseArea {
        anchors.fill: background
        enabled: root.interactive
        onClicked: root.clicked()
    }
}
