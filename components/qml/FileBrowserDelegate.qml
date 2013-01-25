import QtQuick 1.0

ListItem {
    id: root

    height: 64

    Image {
        id: icon

        anchors { left: parent.left; leftMargin: platformStyle.paddingXLarge; verticalCenter: parent.verticalCenter }
        source: fileIsDir ? "image://theme/icon/general_folder" : "image://theme/icon/filemanager_unknown_file"
    }

    Label {
        anchors { left: icon.right; leftMargin: platformStyle.paddingNormal; right: parent.right; rightMargin: platformStyle.paddingNormal; verticalCenter: parent.verticalCenter }
        elide: platformStyle.elideMode
        clip: true
        text: !fileName ? "" : fileName
    }
}
