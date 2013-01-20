import QtQuick 1.0
import "CreateObject.js" as ObjectCreator

Row {
    id: root

    property bool exclusive: true
    property Item checkedButton

    function __setUpButton(button, index, len) {
        var style = ObjectCreator.createObject(Qt.resolvedUrl("ButtonRowStyle.qml"), button);
        style.buttonIndex = index;
        style.buttonRowLength = len;
        button.platformStyle = style;
        button.checkable = root.exclusive;
        button.__exclusive = root.exclusive;
        button.checkChanged.connect(__setCheckedButton);

        if (button.checked) {
            __setCheckedButton(button);
        }
    }

    function __setCheckedButton(button) {
        if (button.checked) {
            checkedButton = button;
        }

        for (var i = 0; i < children.length; i++) {
            if (children[i] !== checkedButton) {
                children[i].checked = false;
            }
        }
    }

    objectName: "__buttonRow"

    Component.onCompleted: {
        for (var i = 1; i <= children.length; i++) {
            __setUpButton(children[i - 1], i, children.length);
        }
    }

    Component.onDestruction: {
        for (var i = 0; i < children.length; i++) {
            children[i].checkChanged.disconnect(__setCheckedButton);
        }
    }
}
