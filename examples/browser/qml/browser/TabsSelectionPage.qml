import QtQuick 1.0
import org.hildon.components 1.0

Page {
    id: root

    EditBar {
        id: editBar

        titleText: qsTr("Select tabs to close")

        EditButton {
            text: qsTr("Close")
            onClicked: {
                if (view.selectedIndexes.length > 0) {
                    loader.sourceComponent = queryDialog;
                    loader.item.open();
                }
            }
        }

        onBackClicked: pageStack.pop()
        onBackPressAndHold: pageStack.pop(null)
    }

    ListView {
        id: view

        property variant selectedIndexes: []

        function sortDescending(a, b) {
            return b - a;
        }

        function toggleChecked(index) {
            var list = view.selectedIndexes;
            var i = list.indexOf(index);

            if (i >= 0) {
                list.splice(i, 1);
            }
            else {
                list.push(index);
            }

            view.selectedIndexes = list;
        }

        anchors.fill: parent
        model: tabs
        delegate: tabDelegate
    }

    ScrollDecorator {
        flickableItem: view
    }

    Component {
        id: tabDelegate

        ListItem {
            height: 90
            checkable: true
            checked: view.selectedIndexes.indexOf(index) >= 0

            Label {
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    margins: platformStyle.paddingNormal
                }
                font.bold: true
                text: modelData.title === "" ? qsTr("Empty tab") : modelData.title
            }

            Label {
                anchors {
                    bottom: parent.bottom
                    left: parent.left
                    right: parent.right
                    margins: platformStyle.paddingNormal
                }
                color: platformStyle.disabledTextColor
                text: modelData.url
            }

            onClicked: view.toggleChecked(index)
        }
    }

    Component {
        id: queryDialog

        QueryDialog {
            titleText: qsTr("Close tabs?")
            message: qsTr("Do you wish to close the selected tabs?")
            acceptButtonText: qsTr("Yes")
            rejectButtonText: qsTr("No")
            onAccepted: {
                var list = view.selectedIndexes;
                list.sort(function(a, b) { return b - a; });

                for (var i = 0; i < list.length; i++) {
                    tabs[i].destroy();
                }

                view.selectedIndexes = [];
                pageStack.pop();
            }
        }
    }

    Loader {
        id: loader
    }
}
