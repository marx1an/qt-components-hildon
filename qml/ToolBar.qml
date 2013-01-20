import QtQuick 1.0
import "Utils.js" as Utils

Item {
    id: root

    property Item tools: null
    property Style platformStyle: ToolBarStyle {}

    height: 70
    anchors { left: parent.left; right: parent.right; bottom: parent.bottom }
    onToolsChanged: if (tools) tools.parent = root;

    Component.onCompleted: Utils.findRootItem(root);

    Image {
        id: background

        anchors.fill: parent
        smooth: true
        fillMode: Image.Stretch
        source: platformStyle.background
    }
}
