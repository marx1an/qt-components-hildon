import QtQuick 1.0

FocusScope {
    id: root

    property string title
    property bool destroyWhenPopped: false
    property Item tools: null

    anchors.fill: !parent ? undefined : parent
    onToolsChanged: if (tools) tools.parent = root; // Make sure that the page owns the tools
    visible: pageStack.currentPage === root

    MouseArea {
        anchors.fill: parent
        onClicked: root.forceActiveFocus()
    }
}
