import QtQuick 1.0
import org.hildon.components 1.0

Page {
    id: root

    title: qsTr("List Page")
    tools: MenuLayout {

        MenuItem {
            text: qsTr("Select items")
            onClicked: pageStack.push(Qt.resolvedUrl("ListSelectionPage.qml"))
        }
    }

    ContextMenu {
        id: contextMenu

        ContextMenuLayout {

            ContextMenuItem {
                text: qsTr("Remove")
                onClicked: listModel.remove(list.selectedIndex)
            }
        }
    }

    ListView {
        id: list

        property int selectedIndex

        anchors.fill: parent
        model: ListModel {
            id: listModel

            ListElement { name: "List Item 1"; isChecked: 0 }
            ListElement { name: "List Item 2"; isChecked: 0 }
            ListElement { name: "List Item 3"; isChecked: 0 }
            ListElement { name: "List Item 4"; isChecked: 0 }
            ListElement { name: "List Item 5"; isChecked: 0 }
            ListElement { name: "List Item 6"; isChecked: 0 }
            ListElement { name: "List Item 7"; isChecked: 0 }
            ListElement { name: "List Item 8"; isChecked: 0 }
            ListElement { name: "List Item 9"; isChecked: 0 }
            ListElement { name: "List Item 10"; isChecked: 0 }
        }
        delegate: ListItem {
            checkable: true
            checked: isChecked

            Label {
                anchors {
                    fill: parent
                    leftMargin: platformStyle.paddingNormal
                    rightMargin: platformStyle.paddingNormal
                }
                verticalAlignment: Text.AlignVCenter
                text: name
            }

            onClicked: infoBanner.showMessage(name + " " + qsTr("clicked") + "()")
            onPressAndHold: {
                list.selectedIndex = index;
                contextMenu.open();
            }
        }
    }    
}
