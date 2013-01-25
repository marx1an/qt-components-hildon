import QtQuick 1.0
import org.hildon.components 1.0

Page {
    id: root

    title: "Qt Components Hildon Gallery"
    tools: MenuLayout {

        MenuItem {
            platformIconId: "general_settings"
            text: qsTr("Settings")
            onClicked: settingsDialog.open()
        }

        MenuItem {
            platformIconId: "general_help"
            text: qsTr("About")
            onClicked: aboutDialog.open()
        }
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
        text: qsTr("Welcome to the Qt Components Hildon Gallery. This gallery is a demonstration of the available components.")
    }

    Flickable {
        id: flicker

        anchors {
            top: heading.bottom
            topMargin: platformStyle.paddingNormal
            left: parent.left
            leftMargin: platformStyle.paddingNormal
            right: parent.right
            rightMargin: platformStyle.paddingNormal
            bottom: parent.bottom
        }
        contentHeight: flow.height + platformStyle.paddingNormal
        clip: true

        Flow {
            id: flow

            property int itemWidth: screen.inPortrait ? width : Math.floor((width / 2) - (spacing / 2))

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }
            spacing: platformStyle.paddingSmall

            Button {
                width: flow.itemWidth
                text: qsTr("Buttons")
                onClicked: pageStack.push(Qt.resolvedUrl("ButtonsPage.qml"))
            }

            Button {
                width: flow.itemWidth
                text: qsTr("Sliders")
                onClicked: pageStack.push(Qt.resolvedUrl("SlidersPage.qml"))
            }

            Button {
                width: flow.itemWidth
                text: qsTr("Dialogs")
                onClicked: pageStack.push(Qt.resolvedUrl("DialogsPage.qml"))
            }

            Button {
                width: flow.itemWidth
                text: qsTr("Menus")
                onClicked: pageStack.push(Qt.resolvedUrl("MenusPage.qml"))
            }

            Button {
                width: flow.itemWidth
                text: qsTr("Text input")
                onClicked: pageStack.push(Qt.resolvedUrl("TextPage.qml"))
            }

            Button {
                width: flow.itemWidth
                text: qsTr("Processes")
                onClicked: pageStack.push(Qt.resolvedUrl("ProcessPage.qml"))
            }

            Button {
                width: flow.itemWidth
                text: qsTr("List views")
                onClicked: pageStack.push(Qt.resolvedUrl("ListPage.qml"))
            }

            Button {
                width: flow.itemWidth
                text: qsTr("Table views")
                onClicked: pageStack.push(Qt.resolvedUrl("TablePage.qml"))
            }
        }
    }

    ScrollDecorator {
        flickableItem: flicker
    }

    SettingsDialog {
        id: settingsDialog
    }

    AboutDialog {
        id: aboutDialog
    }
}
