import QtQuick 1.0

Item {
    id: root

    property bool showBusyIndicator: false
    property bool showMenuIndicator: false
    property alias title: titleLabel.text

    signal clicked

    height: 56
    clip: true

    Label {
        id: titleLabel

        property int maximumWidth: root.showBusyIndicator ? parent.width - busyIndicator.width - platformStyle.paddingNormal * 2  : parent.width - platformStyle.paddingNormal * 2

        width: paintedWidth < maximumWidth ? paintedWidth : maximumWidth
        anchors { left: parent.left; leftMargin: platformStyle.paddingNormal; verticalCenter: parent.verticalCenter }
        verticalAlignment: Text.AlignVCenter
        clip: true
    }

    Image {
        id: menuIndicator

        anchors { left: titleLabel.right; leftMargin: 5; verticalCenter: parent.verticalCenter }
        source: "image://theme/wmMenuIndicator"
        visible: (root.showMenuIndicator) && (!root.showBusyIndicator) && (titleLabel.paintedWidth <= titleLabel.maximumWidth)
    }

    BusyIndicator {
        id: busyIndicator

        anchors { left: titleLabel.right; leftMargin: 5; verticalCenter: parent.verticalCenter }
        visible: root.showBusyIndicator
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        onClicked: root.clicked()
    }
}
