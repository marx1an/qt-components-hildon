import QtQuick 1.0
import "." 1.0

FocusScope {
    id: root

    property bool enabled: true
    property bool pressed: mouseArea.pressed
    property bool highlightValueText: true
    property alias text: label.text
    property variant value
    property string valueText
    property int valueLayout: ValueLayout.ValueUnderText
    property string platformIconId
    property alias iconSource: icon.source
    property alias iconSize: icon.sourceSize
    property Style platformStyle: ButtonStyle {}

    signal clicked

    objectName: "__button"
    width: platformStyle.buttonWidth
    height: platformStyle.buttonHeight

    BorderImage {
        id: background

        anchors.fill: parent
        source: !root.enabled ? platformStyle.disabledBackground : mouseArea.pressed ? platformStyle.pressedBackground : platformStyle.background
        smooth: true
        border {
            left: platformStyle.backgroundMarginLeft
            right: platformStyle.backgroundMarginRight
            top: platformStyle.backgroundMarginTop
            bottom: platformStyle.backgroundMarginBottom
        }
    }

    Text {
        id: label

        anchors { left: icon.visible ? icon.right : parent.left
            leftMargin: platformStyle.textMarginLeft
            right: valueLabel.left
            rightMargin: platformStyle.textMarginRight
            verticalCenter: parent.verticalCenter
        }
        font.pixelSize: platformStyle.fontSizeNormal
        font.weight: platformStyle.fontWeight
        font.capitalization: platformStyle.fontCapitalization
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        color: !root.enabled ? platformStyle.disabledTextColor : mouseArea.pressed ? platformStyle.pressedTextColor : platformStyle.textColor
        clip: true
    }

    Text {
        id: valueLabel

        anchors { left: parent.horizontalCenter; right: parent.right; rightMargin: platformStyle.textMarginRight; verticalCenter: parent.verticalCenter }
        font.pixelSize: platformStyle.fontSizeNormal
        font.weight: platformStyle.fontWeight
        font.capitalization: platformStyle.fontCapitalization
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        color: !root.enabled ? platformStyle.disabledTextColor : root.highlightValueText ? theme.activeTextColor : platformStyle.textColor
        clip: true
        text: valueText
    }

    Image {
        id: icon

        width: sourceSize.width
        height: sourceSize.height
        anchors { left: parent.left; leftMargin: platformStyle.textMarginLeft; verticalCenter: parent.verticalCenter }
        visible: source != ""
        source: root.platformIconId == "" ? "" : "image://theme/icon/" + root.platformIconId
        opacity: root.enabled ? 1 : 0.3
        smooth: true
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        enabled: root.enabled
        onClicked: root.clicked()
    }

    states: [
        State {
            name: "value-under-text"
            when: (root.valueLayout === ValueLayout.ValueUnderText) || (icon.visible)
            AnchorChanges { target: label; anchors { verticalCenter: undefined; top: parent.top; right: parent.right } }
            PropertyChanges { target: label; anchors.topMargin: 8 }
            AnchorChanges { target: valueLabel; anchors { verticalCenter: undefined; left: label.left; bottom: parent.bottom } }
            PropertyChanges { target: valueLabel; anchors.bottomMargin: 8; font.pixelSize: platformStyle.fontSizeSmall }
        },

        State {
            name: "value-under-text-centered"
            when: (root.valueLayout === ValueLayout.ValueUnderTextCentered) && (!icon.visible)
            AnchorChanges { target: label; anchors { verticalCenter: undefined; top: parent.top; right: parent.right } }
            PropertyChanges { target: label; anchors.topMargin: 8; horizontalAlignment: Text.AlignHCenter }
            AnchorChanges { target: valueLabel; anchors { left: undefined; verticalCenter: undefined; bottom: parent.bottom; horizontalCenter: parent.horizontalCenter } }
            PropertyChanges { target: valueLabel; anchors.bottomMargin: 8; font.pixelSize: platformStyle.fontSizeSmall; horizontalAlignment: Text.AlignHCenter }
        }
    ]
}
