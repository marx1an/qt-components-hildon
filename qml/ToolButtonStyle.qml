import QtQuick 1.0

ButtonStyle {
    buttonWidth: 70
    buttonHeight: 70

    fontCapitalization: Font.MixedCase
    fontWeight: Font.Normal
    horizontalAlignment: Text.AlignHCenter
    
    background: "image://theme/toolbar_button_normal"
    pressedBackground: "image://theme/toolbar_button_pressed"
    disabledBackground: "image://theme/toolbar_button_disabled"
}
