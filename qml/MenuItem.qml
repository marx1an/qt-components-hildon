import QtQuick 1.0

Button {
    id: root

    objectName: "__menuItem"
    width: !parent ? 0 : parent.columns === 1 ? parent.width : Math.floor(parent.width / parent.columns)
    onClicked: parent.parent.closeLayout();
}
