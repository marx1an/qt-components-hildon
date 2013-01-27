import QtQuick 1.0
import org.hildon.components 1.0

Page {
    id: root

    title: qsTr("Bookmarks")
    tools: MenuLayout {

        MenuItem {
            text: qsTr("Delete")
            onClicked: pageStack.push(Qt.resolvedUrl("BookmarksSelectionPage.qml"))
        }
    }

    ContextMenu {
        id: contextMenu

        ContextMenuLayout {

            ContextMenuItem {
                text: qsTr("Edit")
                onClicked: {
                    loader.sourceComponent = bookmarkDialog;
                    loader.item.name = bookmarks.data(view.selectedIndex, "title");
                    loader.item.address = bookmarks.data(view.selectedIndex, "url");
                    loader.item.open();
                }
            }

            ContextMenuItem {
                text: qsTr("Delete")
                onClicked: bookmarks.removeBookmark(view.selectedIndex) ? infoBanner.showMessage(qsTr("Bookmark deleted"))
                                                                        : infoNote.showMessage(qsTr("Cannot delete bookmark"))
            }
        }
    }

    ListView {
        id: view

        property int selectedIndex: -1

        anchors.fill: parent
        model: bookmarks
        delegate: bookmarkDelegate
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
        text: qsTr("No bookmarks")
        visible: bookmarks.count === 0
    }

    Component {
        id: bookmarkDelegate

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
                text: title
            }

            Label {
                anchors {
                    bottom: parent.bottom
                    left: parent.left
                    right: parent.right
                    margins: platformStyle.paddingNormal
                }
                color: platformStyle.disabledTextColor
                text: url
            }

            onClicked: {
                tabGroup.addTab(url);
                pageStack.pop();
            }
            onPressAndHold: {
                view.selectedIndex = index;
                contextMenu.open();
            }
        }
    }

    Component {
        id: bookmarkDialog

        EditBookmarkDialog {
            onAccepted: {
                if ((!bookmarks.setData(view.selectedIndex, name, "title")) || (!bookmarks.setData(view.selectedIndex, address, "url"))) {
                    infoNote.showMessage(qsTr("Cannot edit bookmark"));
                }
            }
        }
    }

    Loader {
        id: loader
    }
}
