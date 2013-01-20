import QtQuick 1.0

FocusScope {
    id: root

    property bool enabled: true
    property alias placeholderText: placeholder.text
    property alias readOnly: textInput.readOnly
    property alias text: textInput.text
    property alias selectedText: textInput.selectedText
    property alias inputMethodHints: textInput.inputMethodHints
    property alias validator: textInput.validator
    property alias acceptableInput: textInput.acceptableInput
    property alias echoMode: textInput.echoMode
    property Style platformStyle: TextFieldStyle {}

    signal accepted

    function copy() {
        textInput.copy();
    }

    function paste() {
        textInput.paste();
    }

    function cut() {
        textInput.cut();
    }

    function closeSoftwareInputPanel() {
        textInput.closeSoftwareInputPanel();
    }

    function openSoftwareInputPanel() {
        textInput.openSoftwareInputPanel();
    }

    function positionAt(x, y) {
        textInput.positionAt(x, y);
    }

    function positionToRectangle(position) {
        textInput.positionToRectangle(position);
    }

    function select(start, end) {
        textInput.select(start, end);
    }

    function selectAll() {
        textInput.selectAll();
    }

    width: platformStyle.defaultWidth
    height: 70
    onFocusChanged: if (focus) textInput.focus = true;
    Keys.forwardTo: textInput

    BorderImage {
        id: background

        anchors.fill: parent
        border {
            left: platformStyle.backgroundCornerMargin
            right: platformStyle.backgroundCornerMargin
            top: platformStyle.backgroundCornerMargin
            bottom: platformStyle.backgroundCornerMargin
        }
        source: !root.enabled ? platformStyle.backgroundDisabled : textInput.activeFocus ? platformStyle.backgroundSelected : platformStyle.background
        smooth: true
    }

    TextInput {
        id: textInput

        anchors {
            top: parent.top
            topMargin: platformStyle.paddingLarge
            bottom: parent.bottom
            bottomMargin: platformStyle.paddingSmall
            left: parent.left
            leftMargin: platformStyle.paddingLeft
            right: parent.right
            rightMargin: platformStyle.paddingRight
        }
        onAccepted: root.accepted()
    }

    Label {
        id: placeholder

        anchors { left: textInput.left; verticalCenter: parent.verticalCenter }
        color: "#4d4d4d"
        visible: (textInput.text == "") && (!textInput.activeFocus)
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        enabled: !root.enabled
    }
}
