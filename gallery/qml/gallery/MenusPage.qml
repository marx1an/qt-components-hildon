import QtQuick 1.0
import org.hildon.components 1.0

Page {
    id: root

    title: qsTr("Menus")
    tools: MenuLayout {

        actions: MenuActionGroup {
            id: actionGroup

            checkedAction: children[1]

            MenuAction {
                text: qsTr("MenuAction")
            }

            MenuAction {
                text: qsTr("MenuAction")
            }

            MenuAction {
                text: qsTr("MenuAction")
            }
        }

        MenuItem {
            text: qsTr("MenuItem")
        }

        SelectionButton {
            text: qsTr("SelectionButton")
            platformIconId: "general_device_root_folder"
            valueText: qsTr("Value under text")
            valueLayout: ValueLayout.ValueUnderText
        }

        CheckBox {
            text: qsTr("CheckBox")
        }

        Slider {}
    }

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
        text: qsTr("Click the title area in the status bar to show the menu, or press and hold in the area below to show the context menu.")
    }

    ContextMenu {
        id: contextMenu

        ContextMenuLayout {

            ContextMenuItem {
                text: qsTr("Menu item 1")
                onClicked: infoBanner.showMessage(text + " " + qsTr("clicked()"))
            }

            ContextMenuItem {
                text: qsTr("Menu item 2")
                onClicked: infoBanner.showMessage(text + " " + qsTr("clicked()"))
            }

            ContextMenuItem {
                text: qsTr("Menu item 3")
                onClicked: infoBanner.showMessage(text + " " + qsTr("clicked()"))
            }

            ContextMenuItem {
                text: qsTr("Menu item 4")
                onClicked: infoBanner.showMessage(text + " " + qsTr("clicked()"))
            }
        }
    }

    Rectangle {
        anchors {
            top: heading.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            margins: platformStyle.paddingNormal
        }
        color: "transparent"
        radius: 10
        border {
            width: 1
            color: theme.activeTextColor
        }

        MouseArea {
            id: mouseArea

            anchors.fill: parent
            onPressAndHold: contextMenu.open()
        }
    }
}
