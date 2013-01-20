import QtQuick 1.0

Item {
    id: root

    signal pressAndHold
    signal clicked

    height: 56
    clip: true

    Label {
        id: titleLabel

        property int maximumWidth: appWindow.busy ? parent.width - busyIndicator.width - platformStyle.paddingNormal * 2  : parent.width - platformStyle.paddingNormal * 2

        width: paintedWidth < maximumWidth ? paintedWidth : maximumWidth
        anchors { left: parent.left; leftMargin: platformStyle.paddingNormal; verticalCenter: parent.verticalCenter }
        verticalAlignment: Text.AlignVCenter
        clip: true
        text: appWindow.windowTitle
    }

    Image {
        id: menuIndicator

        anchors { left: titleLabel.right; leftMargin: 5; verticalCenter: parent.verticalCenter }
        source: "image://theme/wmMenuIndicator"
        visible: (pageStack.currentPage !== null) && (pageStack.currentPage.tools !== null) && (!appWindow.busy) && (titleLabel.paintedWidth <= titleLabel.maximumWidth)
    }

    BusyIndicator {
        id: busyIndicator

        anchors { left: titleLabel.right; leftMargin: 5; verticalCenter: parent.verticalCenter }
        visible: appWindow.busy
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        onPressAndHold: root.pressAndHold()
        onClicked: root.clicked()
        enabled: (pageStack.currentPage !== null) && (pageStack.currentPage.tools !== null)
    }
}
