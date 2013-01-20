import QtQuick 1.0

SelectionButton {
    id: root

    property alias model: selectionDialog.model
    property variant selectedIndexes: selectionDialog.selectedIndexes

    signal valuesChosen(variant values)

    function setInitialValues(values) {
        for  (var i = 0; i < model.count; i++) {
            if (model.get(i).value === values[i]) {
                selectionDialog.__addIndex(i);
            }
        }

        root.value = selectedIndexes;
        root.valueText = __updateValueText();
    }

    function __updateValueText() {
        valueText = "";

        for (var i = 0; i < selectedIndexes.length; i++) {
            valueText += model.get(selectedIndexes[i]).name + ", ";
        }
    }

    onClicked: selectionDialog.open()
    Component.onCompleted: if (value) setInitialValues(value);

    MultiSelectionDialog {
        id: selectionDialog

        titleText: root.text
        onSelectedIndexesChanged: root.valueText = __updateValueText()
    }
}
