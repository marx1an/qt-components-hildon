import QtQuick 1.0
import org.hildon.components 1.0

Page {
    id: root

    title: qsTr("Buttons")

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
        text: qsTr("Below are the different buttons available.")
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
                text: qsTr("Button")
                onClicked: infoBanner.showMessage(qsTr("Button clicked()"))
                onPressAndHold: infoBanner.showMessage(qsTr("Button pressAndHold()"))
            }

            Button {
                width: flow.itemWidth
                checkable: true
                text: qsTr("Button (checkable)")
                onClicked: checked ? infoBanner.showMessage(qsTr("Button checked")) : infoBanner.showMessage(qsTr("Button unchecked"))
            }

            CheckBox {
                width: flow.itemWidth
                text: qsTr("Fullscreen")
                checked: appWindow.fullScreen
                onCheckedChanged: appWindow.fullScreen = checked
            }

            DialogButton {
                width: flow.itemWidth
                text: qsTr("DialogButton")
                onClicked: infoBanner.showMessage(qsTr("DialogButton clicked()"))
            }

            SelectionButton {
                width: flow.itemWidth
                text: qsTr("SelectionButton")
                valueText: qsTr("Value under text")
                valueLayout: ValueLayout.ValueUnderText
                onClicked: infoBanner.showMessage(qsTr("SelectionButton clicked()"))
            }

            SelectionButton {
                width: flow.itemWidth
                text: qsTr("SelectionButton")
                valueText: qsTr("Value under text centered")
                valueLayout: ValueLayout.ValueUnderTextCentered
                onClicked: infoBanner.showMessage(qsTr("SelectionButton clicked()"))
            }

            SelectionButton {
                width: flow.itemWidth
                text: qsTr("SelectionButton")
                valueText: qsTr("Value beside text")
                valueLayout: ValueLayout.ValueBesideText
                onClicked: infoBanner.showMessage(qsTr("SelectionButton clicked()"))
            }

            ButtonRow {
                id: buttonRow

                width: parent.width

                Button {
                    text: qsTr("Row")
                }

                Button {
                    text: qsTr("Of")
                }

                Button {
                    text: qsTr("Buttons")
                }
            }
        }
    }

    ScrollDecorator {
        flickableItem: flicker
    }
}
