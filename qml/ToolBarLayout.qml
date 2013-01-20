import QtQuick 1.0

Row {
    id: root

    function __update() {
        var childrenWidth = 0;

        for (var i = 0; i < children.length; i++) {
            childrenWidth += children[i].width;
        }

        spacing = (width - childrenWidth) / (i - 1);
    }

    anchors.fill: !parent ? undefined : parent
    onChildrenChanged: __update()
    onWidthChanged: __update()
}
