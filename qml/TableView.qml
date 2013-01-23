import QtQuick 1.0

FocusScope {
    id: root

    default property alias columns: view.columns
    property alias model: view.model
    property bool allowColumnResizing: true

    Row {
        id: header

        z: 1
        height: 28
        anchors {
            top: parent.top
            left: parent.left
        }

        Repeater {
            id: repeater

            model: view.columns.length - 1

            Item {
                id: headerDelegate

                width: view.columns[index].width
                height: header.height

                Label {
                    anchors {
                        fill: parent
                        leftMargin: platformStyle.paddingSmall
                        rightMargin: platformStyle.paddingSmall
                    }
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: view.columns[index].textAlignment
                    clip: true
                    text: view.columns[index].title
                }

                Rectangle {
                    width: 1
                    anchors {
                        top: parent.top
                        bottom: parent.bottom
                        right: parent.right
                    }
                    color: "#4d4d4d"
                }

                MouseArea {
                    property int oldXPos

                    anchors {
                        top: parent.top
                        bottom: parent.bottom
                        left: parent.right
                        leftMargin: -10
                        right: parent.right
                        rightMargin: -10
                    }
                    enabled: root.allowColumnResizing
                    onPressed: oldXPos = mouseX
                    onMouseXChanged: view.columns[index].width += (mouseX - oldXPos)
                }
            }
        }
    }

    Item {
        z: 1
        height: header.height
        anchors {
            left: header.right
            right: root.right
        }

        Label {
            anchors {
                fill: parent
                leftMargin: platformStyle.paddingSmall
                rightMargin: platformStyle.paddingSmall
            }
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: view.columns[view.columns.length - 1].textAlignment
            clip: true
            text: view.columns.length === 0 ? "" : view.columns[view.columns.length - 1].title
        }
    }

    ListView {
        id: view

        property list<TableColumn> columns

        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        delegate: Row {
            id: delegateRow

            Repeater {
                model: view.columns

                Loader {
                    width: modelData.width
                    sourceComponent: delegate
                }
            }
        }

        ScrollDecorator {
            flickableItem: view
        }
    }
}
