import QtQuick 1.0

Label {
    id: root

    property string link

    signal clicked

    color: mouseArea.pressed ? Qt.lighter(platformStyle.selectedTextColor) : platformStyle.selectedTextColor

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        onClicked: {
            root.clicked();
            Qt.openUrlExternally(root.link);
        }
    }
}
