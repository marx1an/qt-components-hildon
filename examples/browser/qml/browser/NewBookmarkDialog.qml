import QtQuick 1.0
import org.hildon.components 1.0

Dialog {
    id: root

    property alias name: nameInput.text
    property alias address: addressInput.text

    height: screen.inPortrait ? grid.height + 150 : grid.height + 60
    titleText: qsTr("Add bookmark")
    content: Item {
        anchors.fill: parent

        Grid {
            id: grid

            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            rows: 2
            columns: 2
            spacing: platformStyle.paddingSmall

            Label {
                text: qsTr("Name")
                height: nameInput.height
                verticalAlignment: Text.AlignVCenter
            }

            TextField {
                id: nameInput

                width: parent.width - 100
                focus: true
            }

            Label {
                text: qsTr("Address")
                height: addressInput.height
                verticalAlignment: Text.AlignVCenter
            }

            TextField {
                id: addressInput

                width: parent.width - 100
            }
        }
    }

    buttons: DialogButton {
        text: qsTr("Save")
        enabled: (nameInput.text != "") && (addressInput.text != "")
        onClicked: {
            if (bookmarks.addBookmark(nameInput.text, addressInput.text)) {
                infoBanner.showMessage(qsTr("Bookmark added"));
            }
            else {
                infoNote.showMessage(qsTr("Cannot add bookmark"));
            }

            root.accept();
        }
    }
}
