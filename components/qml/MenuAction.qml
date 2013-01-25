import QtQuick 1.0

Button {
    id: root

    signal triggered(variant action)

    checkable: true
    __exclusive: true
    width: !parent ? 0 : parent.width / parent.children.length
    onCheckedChanged: if (checked) triggered(root);
}
