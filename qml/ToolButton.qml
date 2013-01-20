import QtQuick 1.0

FocusScope {
    id: root

    property bool enabled: true
    property bool pressed: mouseArea.pressed
    property string platformIconId
    property alias iconSource: icon.source
    property Style platformStyle: ToolButtonStyle {}

    signal clicked
    signal pressAndHold

    width: platformStyle.buttonWidth
    height: platformStyle.buttonHeight

    Image {
        id: background

        anchors.fill: parent
        smooth: true
        fillMode: Image.Stretch
        source: !root.enabled ? platformStyle.disabledBackground : mouseArea.pressed ? platformStyle.pressedBackground : platformStyle.background
    }

    Text {
        id: label

        anchors { left: parent.left; leftMargin: platformStyle.textMarginLeft; right: parent.right; rightMargin: platformStyle.textMarginRight; verticalCenter: parent.verticalCenter }
        elide: platformStyle.elideMode
        font.pixelSize: platformStyle.fontSizeNormal
        font.weight: platformStyle.fontWeight
        font.capitalization: platformStyle.fontCapitalization
        horizontalAlignment: platformStyle.horizontalAlignment
        verticalAlignment: Text.AlignVCenter
        color: !root.enabled ? platformStyle.disabledTextColor : mouseArea.pressed ? platformStyle.pressedTextColor : platformStyle.textColor
        visible: text != ""
    }

    Image {
        id: icon

        anchors.centerIn: parent
        source: root.platformIconId == "" ? "" : "image://theme/icon/" + root.platformIconId
        visible: source != ""
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        enabled: root.enabled
        onClicked: root.clicked()
        onPressAndHold: root.pressAndHold()
    }
}
