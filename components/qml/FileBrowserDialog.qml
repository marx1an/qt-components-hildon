import QtQuick 1.0
import "." 1.0

Dialog {
    id: root

    property alias folder: folderModel.folder
    property alias showDirs: folderModel.showDirs
    property bool showFiles: true
    property variant nameFilters: ["*.*"]
    property bool allowNewFolders: false

    signal fileChosen(string filePath)

    titleText: qsTr("File browser")
    content: Item {
        anchors.fill: parent

        Row {
            id: row

            spacing: 10

            Button {
                id: backButton

                width: 80
                platformIconId: "filemanager_folder_up"
                enabled: folderModel.folderName !== ""
                onClicked: folderModel.folder = folderModel.parentFolder
            }

            SelectionButton {
                id: folderButton

                width: fileList.width - backButton.width - 10
                platformIconId: "general_folder"
                iconSize: "32x32"
                highlightValueText: false
                text: folderModel.folderName
                valueText: folderModel.parentFolder.toString().slice(8)
                onClicked: root.accept()
            }
        }

        FilterListView {
            id: fileList

            onFilterTextChanged: folderModel.query = filterText
            anchors { top: row.bottom; topMargin: platformStyle.paddingNormal; bottom: parent.bottom; left: parent.left; right: parent.right }
            clip: true
            model: FileSystemModel {
                id: folderModel

                folder: "/"
                showDirs: root.showDirs
                showDirsFirst: true
                showDotAndDotDot: false
                nameFilters: !root.showFiles ? ["*.no_files"] : root.nameFilters
                onFolderChanged: fileList.filterText = ""
            }
            delegate: FileBrowserDelegate {
                onClicked: fileIsDir ? folderModel.folder = filePath : root.fileChosen(filePath)
            }

            ScrollDecorator {
                flickableItem: fileList
            }
        }
    }

    buttons: DialogButton {
        text: qsTr("New")
        visible: root.allowNewFolders
        onClicked: newFolderDialog.open()
    }

    onFileChosen: root.accept()

    NewFolderDialog {
        id: newFolderDialog

        parentFolder: folderModel.folderName
        onAccepted: folderModel.newFolder(newFolderDialog.folderName)
    }
}
