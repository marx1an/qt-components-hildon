import QtQuick 1.0

FocusScope {
    id: root

    property bool enabled: true
    property int maxHeight: textInput.height
    property alias readOnly: textInput.readOnly
    property alias text: textInput.text
    property alias selectedText: textInput.selectedText
    property alias wrapMode: textInput.wrapMode
    property Style platformStyle: TextAreaStyle {}

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
    height: Math.min(root.maxHeight, textInput.height + platformStyle.paddingXLarge)

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

    TextEdit {
        id: textInput

        height: Math.max(120, paintedHeight + platformStyle.paddingXLarge)
        anchors { top: parent.top; left: parent.left; right: parent.right; margins: platformStyle.paddingLeft }
        wrapMode: Text.WordWrap

        MouseArea {
            anchors.fill: parent
            enabled: !root.enabled
        }
    }
}
