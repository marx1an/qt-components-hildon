import QtQuick 1.0

Style {
    property color textColor: theme.defaultTextColor
    property color selectedTextColor: theme.activeTextColor
    property color selectionColor: theme.selectionColor

    property url background: "image://theme/TextInputFrame"
    property url backgroundSelected: "image://theme/TextInputFrameFocused"
    property url backgroundDisabled: "image://theme/TextInputFrameDisabled"
    property real backgroundCornerMargin: 22
    property real paddingLeft: 16
    property real paddingRight: 16

    property real baselineOffset: 2
    property real defaultWidth: 250

}
