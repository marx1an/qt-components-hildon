import QtQuick 1.0

Row {
    id: root

    z: 1000
    anchors {
        left: !parent ? undefined : parent.left
        right: !parent ? undefined : parent.right
        top: !parent ? undefined : parent.top
    }
}
