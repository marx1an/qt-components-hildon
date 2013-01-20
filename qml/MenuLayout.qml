import QtQuick 1.0
import "CreateObject.js" as ObjectCreator

Item {
    id: root

    default property alias gridChildren: grid.children
    property alias actions: actions.children
    property Style platformStyle: Style {}

    function closeLayout() {
        parent.close();
    }

    objectName: "__menuLayout"
    visible: (parent) && ((parent.objectName == "__menu") || (parent.objectName == "__contextMenu"))
    height: childrenRect.height
    anchors {
        top: parent.top
        left: parent.left
        right: parent.right
        margins: platformStyle.paddingNormal
    }

    Item {
        id: actions

        height: childrenRect.height
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
    }

    Grid {
        id: grid

        function __update() {
            var cl = [];
            var i = children.length - 1;

            while (i >= 0) {
                cl.push(children[i]);
                i--;
            }

            while (cl.length !== 0) {
                var item = cl.pop();

                if (item.objectName !== "__menuItem") {
                    var menuItem = ObjectCreator.createObject(Qt.resolvedUrl("AbstractMenuItem.qml"), grid);
                    item.parent = menuItem;
                }
            }
        }

        columns: screen.inPortrait ? 1 : 2
        anchors {
            top: actions.children.length == 0 ? parent.top : actions.bottom
            topMargin: actions.children.length == 0 ? 0 : platformStyle.paddingNormal
            left: parent.left
            right: parent.right
        }

        Component.onCompleted: __update()
    }
}
