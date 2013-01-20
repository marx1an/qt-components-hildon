import QtQuick 1.0
import "." 1.0

Dialog {
    id: root

    property alias folderName: folderInput.text
    property alias parentFolder: parentFolderLabel.text

    titleText: qsTr("New folder")
    height: screen.inPortrait ? 280 : 200
    content: Item {
        id: contentItem

        anchors.fill: parent

        Column {
            id: column

            anchors { top: parent.top; left: parent.left; right: parent.right }
            spacing: platformStyle.paddingNormal

            TextField {
                id: folderInput

                width: parent.width
            }

            Row {
               id: row

               spacing: platformStyle.paddingSmall

               Image {
                   id: icon

                   source: "image://theme/icon/general_folder"
                   smooth: true
               }

               Label {
                   id: parentFolderLabel

                   width: column.width - icon.width - platformStyle.paddingNormal
                   height: icon.height
                   verticalAlignment: Text.AlignVCenter
               }
            }
        }
    }

    buttons: DialogButton {
        text: qsTr("Save")
        onClicked: root.accept()
    }

    onStatusChanged: {
        if (root.status === DialogStatus.Opening) {
            folderInput.text = qsTr("Folder")
            folderInput.selectAll();
        }
    }
}
