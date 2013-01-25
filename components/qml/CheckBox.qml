import QtQuick 1.0

Item {
    id: root

    property bool enabled: true
    property bool checked: false
    property bool pressed: mouseArea.pressed
    property alias text: label.text
    property string platformIconId
    property alias iconSource: icon.source
    property alias iconSize: icon.sourceSize
    property Style buttonStyle: ButtonStyle {}
    property Style platformStyle: CheckBoxStyle {}

    signal clicked

    objectName: "__checkbox"
    width: buttonStyle.buttonWidth
    height: buttonStyle.buttonHeight

    BorderImage {
        id: background

        anchors.fill: parent
        source: !root.enabled ? buttonStyle.disabledBackground : mouseArea.pressed ? buttonStyle.pressedBackground : buttonStyle.background
        smooth: true
        border {
            left: buttonStyle.backgroundMarginLeft
            right: buttonStyle.backgroundMarginRight
            top: buttonStyle.backgroundMarginTop
            bottom: buttonStyle.backgroundMarginBottom
        }
    }

    Row {
        id: row
        anchors { left: parent.left; leftMargin: buttonStyle.textMarginLeft; right: parent.right; rightMargin: buttonStyle.textMarginRight; verticalCenter: parent.verticalCenter }
        spacing: platformStyle.paddingNormal
        clip: true

        Image {
            id: checkbox

            anchors.verticalCenter: parent.verticalCenter
            source: platformStyle.background
        }

        Image {
            id: icon

            width: sourceSize.width
            height: sourceSize.height
            anchors.verticalCenter: parent.verticalCenter
            visible: source != ""
            source: root.platformIconId == "" ? "" : "image://theme/icon/" + root.platformIconId
            opacity: root.enabled ? 1 : 0.3
            smooth: true
        }

        Label {
            id: label

            width: parent.width - checkbox.width - platformStyle.paddingNormal + (icon.visible ? icon.width : 0)
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideNone
            clip: true
            opacity: root.enabled ? 1 : 0.3
        }
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        enabled: root.enabled
        onClicked: {
            root.checked = !root.checked;
            root.clicked();
        }
    }

    states: [
        State {
            name: "checked"
            when: (root.checked) && (root.enabled)
            PropertyChanges { target: checkbox; source: platformStyle.backgroundSelected }
        },

        State {
            name: "disabled"
            when: (!root.enabled) && (!root.checked)
            PropertyChanges { target: checkbox; source: platformStyle.backgroundDisabled }
        },

        State {
            name: "checkedDisabled"
            when: (root.checked) && (!root.enabled)
            PropertyChanges { target: checkbox; source: platformStyle.backgroundSelectedDisabled }
        }
    ]
}
