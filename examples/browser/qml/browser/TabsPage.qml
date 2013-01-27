import QtQuick 1.0
import org.hildon.components 1.0

Page {
    id: root

    title: qsTr("Tabs")
    tools: MenuLayout {

        MenuItem {
            text: qsTr("Close")
            onClicked: pageStack.push(Qt.resolvedUrl("TabsSelectionPage.qml"))
        }
    }

    ContextMenu {
        id: contextMenu

        ContextMenuLayout {

            ContextMenuItem {
                text: qsTr("Close")
                onClicked: tabs[view.selectedIndex].destroy()
            }
        }
    }

    ListView {
        id: view

        property int selectedIndex: -1

        anchors.fill: parent
        model: tabs
        delegate: tabDelegate
    }

    ScrollDecorator {
        flickableItem: view
    }

    Label {
        anchors {
            fill: parent
            margins: platformStyle.paddingLarge
        }
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font {
            bold: true
            pixelSize: theme.fontSizeXLarge
        }
        color: platformStyle.disabledTextColor
        text: qsTr("No tabs open")
        visible: view.count == 0
    }

    Component {
        id: tabDelegate

        ListItem {
            height: 90

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

            onClicked: {
                currentTab = modelData;
                pageStack.pop();
            }
            onPressAndHold: {
                view.selectedIndex = index;
                contextMenu.open();
            }
        }
    }
}
