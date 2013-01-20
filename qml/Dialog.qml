import QtQuick 1.0

Popup {
    id: root

    signal accepted
    signal rejected

    function accept() {
        root.close();
        root.accepted();
    }

    function reject() {
        root.close();
        root.rejected();
    }

    property alias titleText: titleLabel.text
    property alias content: contentItem.children
    property alias buttons: buttonsColumn.children
    property bool busy: false
    property Style platformStyle: DialogStyle {}

    objectName: "__dialog"
    height: screen.inPortrait ? 680 : 360 //TODO: Make height dependent on content height
    anchors { left: !parent ? undefined : parent.left; right: !parent ? undefined : parent.right; top: !parent ? undefined : parent.bottom }

    Rectangle {
        id: background

        anchors.fill: parent
        color: platformStyle.backgroundColor
    }

    Image {
        id: titleBackground

        anchors { top: parent.top; left: parent.left; right: parent.right }
        source: platformStyle.titleBackground
        fillMode: Image.TileHorizontally
        smooth: true
    }

    Row {
        id: titleRow

        height: titleBackground.height
        anchors.centerIn: titleBackground
        visible: titleLabel.text != ""

        Label {
            id: titleLabel

            height: busyIndicator.height
            verticalAlignment: Text.AlignVCenter
        }

        BusyIndicator {
            id: busyIndicator

            visible: root.busy
        }
    }

    Item {
        id: contentItem

        anchors {
            left: parent.left
            leftMargin: platformStyle.paddingNormal
            right: (screen.inPortrait) || (!buttonsColumn.visible) ? parent.right : buttonsColumn.left
            rightMargin: platformStyle.paddingNormal
            top: titleBackground.bottom
            bottom: (screen.inPortrait) && (buttonsColumn.visible) ? buttonsColumn.top : buttonsColumn.bottom
            bottomMargin: (screen.inPortrait) && (buttonsColumn.visible) ? platformStyle.paddingNormal : 0
        }
        clip: true
    }

    Column {
        id: buttonsColumn

        function __update() {
            var i = 0;

            while ((!visible) && (i < children.length)) {
                visible = (children[i].text !== "") && (children[i].iconSource !== "");
                i++;
            }
        }

        width: screen.inPortrait ? parent.width - 30 : 150
        anchors { right: parent.right; rightMargin: platformStyle.buttonsRightMargin; bottom: parent.bottom; bottomMargin: platformStyle.buttonsRightMargin }
        spacing: platformStyle.buttonsColumnSpacing
        visible: false
        onChildrenChanged: __update()
        Component.onCompleted: __update()
    }
}
