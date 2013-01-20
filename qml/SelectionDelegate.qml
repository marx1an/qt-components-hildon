import QtQuick 1.1

ListItem {
    id: root

    property alias text: label.text

    Label {
        id: label

        anchors { fill: parent; leftMargin: platformStyle.paddingNormal; rightMargin: platformStyle.paddingNormal; verticalCenter: parent.verticalCenter }
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
