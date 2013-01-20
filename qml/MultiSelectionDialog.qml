import QtQuick 1.0
import "." 1.0

Dialog {
    id: root

    property Style platformStyle: SelectionDialogStyle {}
    property alias model: list.model
    property alias delegate: list.delegate
    property variant selectedIndexes: []
    property alias acceptButtonText: acceptButton.text
    property alias rejectButtonText: rejectButton.text

    function __addIndex(index) {
        var si = selectedIndexes;
        si.push(index);
        selectedIndexes = si;
    }

    function __removeIndex(index) {
        var si = selectedIndexes;
        si.splice(si.indexOf(index), 1);
        selectedIndexes = si;
    }

    height: Math.min(screen.height - 120, model.count * platformStyle.delegateHeight + 80)
    content: Item {
        anchors.fill: parent

        ListView {
            id: list

            anchors.fill: parent
            model: ListModel {}
            delegate: SelectionDelegate {
                id: delegate

                checkable: true
                isChecked: selectedIndexes.indexOf(index) >= 0
                height: platformStyle.delegateHeight
                text: name
                onClicked: selectedIndexes.indexOf(index) === -1 ? __addIndex(index) : __removeIndex(index)
            }
        }

        ScrollDecorator {
            flickableItem: list
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
