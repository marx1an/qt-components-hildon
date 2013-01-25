import QtQuick 1.0
import org.hildon.components 1.0

Dialog {
    id: root

    titleText: qsTr("Settings")
    content: Item {
        anchors.fill: parent

        Flickable {
            id: flicker

            anchors.fill: parent
            contentWidth: width
            contentHeight: column.height

            Column {
                id: column

                anchors { top: parent.top; left: parent.left; right: parent.right }
                spacing: platformStyle.paddingSmall

                SelectionItem {
                    width: parent.width
                    text: qsTr("Screen orientation")
                    value: platformWindow.screenOrientation
                    model: ListModel {
                        ListElement { name: "Automatic"; value: ScreenOrientation.Automatic }
                        ListElement { name: "Portrait"; value: ScreenOrientation.LockPortrait }
                        ListElement { name: "Landscape"; value: ScreenOrientation.LockLandscape }
                    }
                    onValueChosen: platformWindow.screenOrientation = value
                }
            }
        }

        ScrollDecorator {
            flickableItem: flicker
        }
    }

    buttons: [
        DialogButton {
            text: qsTr("Save")
            onClicked: root.accept()
        },

        DialogButton {
            text: qsTr("Cancel")
            onClicked: root.reject()
        }
    ]
}
