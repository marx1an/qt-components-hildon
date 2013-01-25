import QtQuick 1.0

Item {
    id: root

    signal clicked

    objectName: "__menuItem"
    width: !parent ? 0 : parent.columns === 1 ? parent.width : Math.floor(parent.width / parent.columns)
    height: 70
    onClicked: parent.parent.closeLayout()

    onChildrenChanged: {
        if (children.length > 0) {
            if (children[0].hasOwnProperty("clicked")) {
                children[0].anchors.fill = root;
                children[0].clicked.connect(root.clicked);
            }
            else {
                children[0].anchors.centerIn = root;
            }
        }
    }

    Component.onDestruction: {
        if ((children.length > 0) && (children[0].hasOwnProperty("clicked"))) {
            children[0].clicked.disconnect(root.clicked);
        }
    }
}
