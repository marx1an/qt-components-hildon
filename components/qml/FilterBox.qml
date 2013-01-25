import QtQuick 1.0

ToolBar {
    id: root

    property alias text: textField.text

    signal clearClicked

    opacity: text != "" ? 1 : 0
    Keys.forwardTo: textField

    tools: ToolBarLayout {

        TextField {
            id: textField

            height: parent.height - 5
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width - clearButton.width

            MouseArea {
                anchors.fill: parent
            }
        }

        ToolButton {
            id: clearButton

            platformIconId: "general_close"
            onClicked: {
                textField.text = "";
                root.clearClicked();
            }
        }
    }
}
