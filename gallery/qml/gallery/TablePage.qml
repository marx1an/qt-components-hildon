import QtQuick 1.0
import org.hildon.components 1.0

Page {
    id: root

    title: qsTr("Table Page")

    TableView {
        id: view

        anchors.fill: parent
        model: ListModel {
            ListElement { val1: "Value 1"; val2: "Value 2"; val3: "Value 3"; val4: "Value 4" }
            ListElement { val1: "Value 5"; val2: "Value 6"; val3: "Value 7"; val4: "Value 8" }
            ListElement { val1: "Value 9"; val2: "Value 10"; val3: "Value 11"; val4: "Value 12" }
            ListElement { val1: "Value 13"; val2: "Value 14"; val3: "Value 15"; val4: "Value 16" }
        }

        TableColumn {
            width: 300
            title: "Column 1"
            role: "val1"
            delegate: Label {
                text: val1
            }
        }

        TableColumn {
            width: 160
            title: "Column 2"
            role: "val2"
            delegate: Label {
                text: val2
            }
        }

        TableColumn {
            width: 160
            title: "Column 3"
            role: "val3"
            delegate: Label {
                text: val3
            }
        }

        TableColumn {
            title: "Column 4"
            role: "val4"
            delegate: Label {
                text: val4
            }
        }
    }
}
