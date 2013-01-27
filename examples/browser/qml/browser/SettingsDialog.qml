import QtQuick 1.0
import org.hildon.components 1.0

Dialog {
    id: root

    function saveSettings() {
        settings.setValue("Content/enableJavaScript", jsCheckbox.checked);
        settings.setValue("Other/screenOrientation", orientationSelector.value);
    }

    height: screen.inPortrait ? column.height + 150 : column.height + 60
    titleText: qsTr("Settings")
    content: Item {
        anchors.fill: parent

        Flickable {
            id: flicker

            anchors.fill: parent
            contentHeight: column.height

            Column {
                id: column

                anchors {
                    bottom: parent.bottom
                    left: parent.left
                    right: parent.right
                }
                spacing: platformStyle.paddingSmall

                Label {
                    width: parent.width
                    text: qsTr("Content")
                }

                CheckBox {
                    id: jsCheckbox

                    width: parent.width
                    text: qsTr("Enable JavaScript")
                    checked: settings.value("Content/enableJavaScript", true)
                }

                Label {
                    width: parent.width
                    text: qsTr("Other")
                }

                SelectionItem {
                    id: orientationSelector

                    width: parent.width
                    text: qsTr("Screen orientation")
                    value: settings.value("Other/screenOrientation", platformWindow.screenOrientation)
                    model: ListModel {
                        ListElement { name: "Automatic"; value: ScreenOrientation.Automatic }
                        ListElement { name: "Portrait"; value: ScreenOrientation.LockPortrait }
                        ListElement { name: "Landscape"; value: ScreenOrientation.LockLandscape }
                    }
                }
            }
        }
    }

    buttons: DialogButton {
        text: qsTr("Done")
        onClicked: {
            root.saveSettings();
            root.accept();
        }
    }
}
