import QtQuick 1.0

SelectionButton {
    id: root

    property alias model: selectionDialog.model
    property int selectedIndex: selectionDialog.selectedIndex

    signal valueChosen(variant value)

    function setInitialValue(value) {
        var found = false;
        var i = 0;

        while ((!found) && (i < model.count)) {
            if (model.get(i).value === value) {
                selectionDialog.selectedIndex = i;
                found = true;
            }

            i++;
        }

        if (found) {
            root.value = value;
            root.valueText = model.get(selectionDialog.selectedIndex).name;
        }
    }

    onClicked: selectionDialog.open()
    Component.onCompleted: if (value !== undefined) setInitialValue(value);

    SelectionDialog {
        id: selectionDialog

        titleText: root.text
        onAccepted: {
            root.value = model.get(selectedIndex).value;
            root.valueText = model.get(selectionDialog.selectedIndex).name;
            root.valueChosen(root.value);
        }
    }
}
