import QtQuick 1.0

Item {
    id: root

    property alias text: label.text
    property bool enabled: true
    property Style platformStyle: Style {}

    signal clicked

    width: Math.min(350, label.width + platformStyle.paddingNormal * 2)
    height: 60

    Rectangle {
        anchors.fill: parent
        radius: 5
        color: theme.activeTextColor
        visible: mouseArea.pressed
    }

    Label {
        id: label

        anchors { left: parent.left; leftMargin: platformStyle.paddingNormal; verticalCenter: parent.verticalCenter }
        verticalAlignment: Text.AlignVCenter
        color: root.enabled ? platformStyle.textColor : platformStyle.disabledTextColor
        style: Text.Raised
        clip: true
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        enabled: root.enabled
        onClicked: root.clicked()
    }

    onClicked: root.parent.closeLayout()
}
