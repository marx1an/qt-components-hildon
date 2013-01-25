import QtQuick 1.0
import org.hildon.components 1.0

Page {
    id: root

    title: qsTr("Sliders")

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
        text: qsTr("Below are the different sliders available.")
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

            Label {
                width: flow.itemWidth
                height: slider1.height
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Standard slider") + ":"
            }

            Slider {
                id: slider1

                width: flow.itemWidth
                minimumValue: 0
                maximumValue: 100
                value: 50
            }

            Label {
                width: flow.itemWidth
                height: slider2.height
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Bi-directional slider") + ":"
            }

            Slider {
                id: slider2

                width: flow.itemWidth
                minimumValue: -50
                maximumValue: 50
                bidirectional: true
                value: 0
            }
        }
    }

    ScrollDecorator {
        flickableItem: flicker
    }
}
