import QtQuick 1.0

SelectionButton {
    id: root

    property alias model: selectionDialog.model
    property alias selectedIndexes: selectionDialog.selectedIndexes

    signal valuesChosen(variant values)

    QtObject {
        id: internal

        function __setInitialValues(values) {
            var indexes = [];

            for  (var i = 0; i < selectionDialog.model.count; i++) {
                if (selectionDialog.model.get(i).value === values[i]) {
                    indexes.push(i);
                }
            }

            selectionDialog.selectedIndexes = indexes;
            internal.__updateValueText();
            selectionDialog.selectedIndexesChanged.connect(internal.__updateValueText);
        }

        function __updateValueText() {
            root.valueText = "";

            for (var i = 0; i < selectionDialog.selectedIndexes.length; i++) {
                root.valueText += selectionDialog.model.get(selectionDialog.selectedIndexes[i]).name;

                if (i < (selectionDialog.selectedIndexes.length - 1)) {
                    root.valueText += ", ";
                }
            }
        }
    }

    onClicked: selectionDialog.open()
    Component.onCompleted: if (value) internal.__setInitialValues(value);

    MultiSelectionDialog {
        id: selectionDialog

        titleText: root.text
    }
}
