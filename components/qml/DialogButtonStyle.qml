import QtQuick 1.0

ButtonStyle {
    buttonWidth: !parent ? 0 : parent.width
    background: "image://theme/DialogButtonNormal"
    pressedBackground: "image://theme/DialogButtonPressed"
    disabledBackground: "image://theme/DialogButtonDisabled"
}
