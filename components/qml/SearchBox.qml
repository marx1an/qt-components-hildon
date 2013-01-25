import QtQuick 1.0

Item {
    id: root

    property alias searchText: textField.text
    property alias placeholderText: textField.placeholderText
    property Style platformStyle: Style {}

    height: textField.height + platformStyle.paddingNormal

    SearchTextField {
        id: textField

        anchors { left: parent.left; leftMargin: platformStyle.paddingNormal; right: parent.right; rightMargin: platformStyle.paddingNormal; verticalCenter: parent.verticalCenter }
    }
}
