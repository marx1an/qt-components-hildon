import QtQuick 1.0

Dialog {
    id: root

    property alias icon: icon.source
    property alias message: label.text
    property alias acceptButtonText: acceptButton.text
    property alias rejectButtonText: rejectButton.text

    modal: true
    content: Item {
        anchors.fill: parent

        Flickable {
            id: flicker

            anchors.fill: parent
            contentHeight: row.height
            contentWidth: width

            Row {
                id: row

                anchors { left: parent.left; right:parent.right; top: parent.top }
                spacing: 10

                Image {
                    id: icon
                }

                Label {
                    id: label

                    width: parent.width - icon.width - 10
                    wrapMode: Text.WordWrap
                }
            }
        }

        ScrollDecorator {
            flickableItem: flicker
        }
    }

    buttons: [
        DialogButton {
            id: acceptButton

            visible: text != ""
            onClicked: root.accept()
        },

        DialogButton {
            id: rejectButton

            visible: text != ""
            onClicked: root.reject()
        }
    ]
}
