import QtQuick 1.0
import "CreateObject.js" as ObjectCreator

Row {
    id: root

    property bool exclusive: false
    property Item checkedButton

    QtObject {
        id: internal

        function __setUpButton(button, index, len) {
            var style = ObjectCreator.createObject(Qt.resolvedUrl("ButtonRowStyle.qml"), button);
            style.buttonIndex = index;
            style.buttonRowLength = len;
            button.platformStyle = style;
            button.checkable = root.exclusive;
            button.__exclusive = root.exclusive;
            button.checkChanged.connect(internal.__setCheckedButton);

            if (button.checked) {
                internal.__setCheckedButton(button);
            }
        }

        function __update() {
            for (var i = 1; i <= root.children.length; i++) {
                internal.__setUpButton(root.children[i - 1], i, root.children.length);
            }
        }

        function __setCheckedButton(button) {
            if (button.checked) {
                root.checkedButton = button;
            }

            for (var i = 0; i < root.children.length; i++) {
                if (root.children[i] !== root.checkedButton) {
                    root.children[i].checked = false;
                }
            }
        }
    }

    objectName: "__buttonRow"
    onExclusiveChanged: internal.__update()

    Component.onCompleted: internal.__update()

    Component.onDestruction: {
        for (var i = 0; i < children.length; i++) {
            children[i].checkChanged.disconnect(internal.__setCheckedButton);
        }
    }
}
