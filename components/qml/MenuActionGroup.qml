import QtQuick 1.0
import "CreateObject.js" as ObjectCreator

Row {
    id: root

    property Item checkedAction

    signal triggered(variant action)

    anchors.horizontalCenter: !parent ? undefined : parent.horizontalCenter
    width: !parent ? 0 : Math.min(parent.width, children.length * 150)
    onCheckedActionChanged: triggered(checkedAction)

    function __setUpAction(action, index, len) {
        var style = ObjectCreator.createObject(Qt.resolvedUrl("ButtonRowStyle.qml"), action);
        style.buttonIndex = index;
        style.buttonRowLength = len;
        action.platformStyle = style;
        action.triggered.connect(__setCheckedAction);

        if ((action.checked) || (checkedAction === action)) {
            __setCheckedAction(action);
        }
    }

    function __setCheckedAction(action) {
        action.checked = true;
        checkedAction = action;

        for (var i = 0; i < children.length; i++) {
            if (children[i] !== checkedAction) {
                children[i].checked = false;
            }
        }
    }

    objectName: "actionGroup"

    Component.onCompleted: {
        for (var i = 1; i <= children.length; i++) {
            __setUpAction(children[i - 1], i, children.length);
        }
    }

    Component.onDestruction: {
        for (var i = 0; i < children.length; i++) {
            children[i].triggered.disconnect(__setCheckedAction);
        }
    }
}
