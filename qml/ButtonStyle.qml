import QtQuick 1.0

Style {
    property int horizontalAlignment: Text.AlignHCenter
    property int textMarginRight: 12
    property int textMarginLeft: 12

    property color textColor: theme.buttonTextColor
    property color pressedTextColor: theme.buttonTextPressedColor
    property color disabledTextColor: theme.buttonTextDisabledColor

    property int buttonWidth: 150
    property int buttonHeight: 70

    property int backgroundMarginRight: 10
    property int backgroundMarginLeft: 10
    property int backgroundMarginTop: 10
    property int backgroundMarginBottom: 10

    property url background: "image://theme/FingerButtonNormal"
    property url pressedBackground: "image://theme/FingerButtonPressed"
    property url disabledBackground: "image://theme/FingerButtonDisabled"
}
