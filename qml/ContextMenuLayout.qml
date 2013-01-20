import QtQuick 1.0

Column {
    id: grid

    property Style platformStyle: Style {}

    function closeLayout() {
        parent.close();
    }

    function __update() {
        parent.width = childrenRect.width + platformStyle.paddingNormal * 2;
        parent.height = height + platformStyle.paddingNormal * 2;

        for (var i = 0; i < children.length; i++) {
            children[i].width = childrenRect.width;
        }
    }

    anchors {
        top: parent.top
        left: parent.left
        right: parent.right
        margins: platformStyle.paddingNormal
    }

    Component.onCompleted: __update()
}
