import QtQuick 1.0
import "." 1.0

Dialog {
    id: root

    property int inputMode: -1
    property string labelText
    property alias acceptButtonText: acceptButton.text
    property alias rejectButtonText: rejectButton.text
    property int textEchoMode: TextInput.Normal
    property string textValue
    property int intMinimum: 0
    property int intMaximum: 10
    property int intStepSize: 1
    property int intValue: 0
    property double doubleMinimum: 0.0
    property double doubleMaximum: 10.0
    property double doubleStepSize: 0.1
    property double doubleValue: 0.0
    property Style platformStyle: InputDialogStyle {}

    height: screen.inPortrait ? 270 : 200
    content: Item {
        id: contentItem

        anchors.fill: parent

        Column {
            id: column

            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            spacing: platformStyle.paddingNormal

            Label {
                id: label

                text: root.labelText
                visible: root.inputMode === InputMode.TextInput
            }

            Loader {
                id: loader

                width: parent.width
                height: 70
            }
        }
    }

    buttons: [
        DialogButton {
            id: acceptButton

            text: qsTr("Done")
            visible: text != ""
            onClicked: root.accept()
        },

        DialogButton {
            id: rejectButton

            visible: text != ""
            onClicked: root.reject()
        }
    ]

    Component {
        id: textComponent

        TextField {
            id: textField

            anchors.fill: !parent ? undefined : parent
            echoMode: root.textEchoMode
            text: root.textValue
            onTextChanged: root.textValue = text

            Component.onCompleted: forceActiveFocus()
        }
    }

    Component {
        id: selectionComponent

        SelectionButton {
            id: selectionButton

            anchors.fill: !parent ? undefined : parent
            text: root.labelText
            valueText: root.inputMode === InputMode.IntInput ? root.intValue : root.doubleValue.toFixed(1)
            onClicked: selectionDialog.open()

            SelectionDialog {
                id: selectionDialog

                function __setModel() {
                    var list = [];
                    var i = root.intMinimum;

                    if (root.inputMode === InputMode.IntInput) {
                        while (i <= root.intMaximum) {
                            list.push(i);
                            i += root.intStepSize;
                        }
                    }
                    else {
                        i = root.doubleMinimum;

                        while (i <= root.doubleMaximum) {
                            list.push(i.toFixed(1));
                            i += root.doubleStepSize;
                        }
                    }

                    selectionDialog.model = list;
                }

                titleText: root.labelText
                delegate: Item {
                    signal clicked

                    width: !parent ? 0 : parent.width
                    height: 64

                    Image {
                        id: background

                        z: -1
                        anchors.fill: parent
                        smooth: true
                        source: (mouseArea.pressed) || (selectionDialog.selectedIndex === index) ? "image://theme/TouchListBackgroundPressed" : "image://theme/TouchListBackgroundNormal"
                    }

                    Label {
                        id: label

                        anchors {
                            left: parent.left
                            leftMargin: platformStyle.paddingLarge
                            right: parent.right
                            rightMargin: platformStyle.paddingLarge
                            verticalCenter: parent.verticalCenter
                        }
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: modelData
                    }

                    MouseArea {
                        id: mouseArea

                        z: -1
                        anchors.fill: parent
                        onClicked: {
                            selectionDialog.selectedIndex = index;
                            selectionDialog.accept();
                        }
                    }
                }

                onAccepted: root.inputMode === InputMode.IntInput ? root.intValue = selectionDialog.model[selectionDialog.selectedIndex]
                                                                     : root.doubleValue = selectionDialog.model[selectionDialog.selectedIndex]

                Component.onCompleted: selectionDialog.__setModel()
            }
        }
    }

    onInputModeChanged: {
        switch (root.inputMode) {
        case InputMode.TextInput:
            loader.sourceComponent = textComponent;
            break;
        case InputMode.IntInput:
            loader.sourceComponent = selectionComponent;
            break;
        case InputMode.DoubleInput:
            loader.sourceComponent = selectionComponent;
            break;
        default:
            loader.sourceComponent = null;
            break;
        }
    }
}
