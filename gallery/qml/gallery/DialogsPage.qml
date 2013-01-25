import QtQuick 1.0
import org.hildon.components 1.0

Page {
    id: root

    title: qsTr("Dialog")

    Label {
        id: heading

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            margins: platformStyle.paddingNormal
        }
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
        text: qsTr("Click the buttons to see the different dialogs available.")
    }

    Flickable {
        id: flicker

        anchors {
            top: heading.bottom
            topMargin: platformStyle.paddingNormal
            left: parent.left
            leftMargin: platformStyle.paddingNormal
            right: parent.right
            rightMargin: platformStyle.paddingNormal
            bottom: parent.bottom
        }
        contentHeight: flow.height + platformStyle.paddingNormal
        clip: true

        Flow {
            id: flow

            property int itemWidth: screen.inPortrait ? width : Math.floor((width / 2) - (spacing / 2))

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }
            spacing: platformStyle.paddingSmall

            Button {
                width: flow.itemWidth
                text: qsTr("Dialog")
                onClicked: {
                    dialogLoader.sourceComponent = dialog;
                    dialogLoader.item.open();
                }
            }

            Button {
                width: flow.itemWidth
                text: qsTr("QueryDialog")
                onClicked: {
                    dialogLoader.sourceComponent = queryDialog;
                    dialogLoader.item.open();
                }
            }

            Button {
                width: flow.itemWidth
                text: qsTr("InputDialog (text)")
                onClicked: {
                    dialogLoader.sourceComponent = inputDialog;
                    dialogLoader.item.inputMode = InputMode.TextInput;
                    dialogLoader.item.labelText = qsTr("Text") + ":"
                    dialogLoader.item.open();
                }
            }

            Button {
                width: flow.itemWidth
                text: qsTr("InputDialog (int)")
                onClicked: {
                    dialogLoader.sourceComponent = inputDialog;
                    dialogLoader.item.inputMode = InputMode.IntInput;
                    dialogLoader.item.labelText = qsTr("Integer")
                    dialogLoader.item.open();
                }
            }

            Button {
                width: flow.itemWidth
                text: qsTr("InputDialog (double)")
                onClicked: {
                    dialogLoader.sourceComponent = inputDialog;
                    dialogLoader.item.inputMode = InputMode.DoubleInput;
                    dialogLoader.item.labelText = qsTr("Double")
                    dialogLoader.item.open();
                }
            }

            SelectionItem {
                width: flow.itemWidth
                text: qsTr("SelectionDialog")
                value: valueLayout
                model: ListModel {
                    ListElement { name: "Value under text"; value: ValueLayout.ValueUnderText }
                    ListElement { name: "Value under text centered"; value: ValueLayout.ValueUnderTextCentered }
                    ListElement { name: "Value beside text"; value: ValueLayout.ValueBesideText }
                }
                onValueChosen: valueLayout = value
            }

            MultiSelectionItem {
                width: flow.itemWidth
                text: qsTr("MultiSelectionDialog")
                value: [3, 6]
                model: ListModel {
                    ListElement { name: "Value one"; value: 1 }
                    ListElement { name: "Value two"; value: 2 }
                    ListElement { name: "Value three"; value: 3 }
                    ListElement { name: "Value four"; value: 4 }
                    ListElement { name: "Value five"; value: 5 }
                    ListElement { name: "Value six"; value: 6 }
                    ListElement { name: "Value seven"; value: 7 }
                    ListElement { name: "Value eight"; value: 8 }
                    ListElement { name: "Value nine"; value: 9 }
                    ListElement { name: "Value ten"; value: 10 }
                }
            }
        }
    }

    ScrollDecorator {
        flickableItem: flicker
    }

    Component {
        id: dialog

        Dialog {
            titleText: qsTr("Dialog")
            content: Item {
                anchors.fill: parent

                Flow {
                    anchors {
                        left: parent.left
                        right: parent.right
                        top: parent.top
                    }
                    spacing: platformStyle.paddingNormal

                    Label {
                        width: parent.width
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                        text: qsTr("This is a dialog with some random stuff in it")
                    }

                    Contact {
                        text: qsTr("Contact")
                        avatar: "trollface.png"
                    }

                    WebShortcut {
                        text: qsTr("Web shortcut")
                        thumbnail: "tmo.png"
                    }
                }
            }
        }
    }

    Component {
        id: queryDialog

        QueryDialog {
            titleText: qsTr("Query dialog")
            message: qsTr("This is a query dialog created with Qt Components Hildon. Do you want to use these components?")
            acceptButtonText: qsTr("Yes")
            rejectButtonText: qsTr("No")
            onAccepted: infoBanner.showMessage(qsTr("Congratulation!"))
            onRejected: infoBanner.showMessage(qsTr("Y u no use Qt Components Hildon?"))
        }
    }

    Component {
        id: inputDialog

        InputDialog {
            titleText: qsTr("Input dialog")
        }
    }

    Loader {
        id: dialogLoader
    }
}
