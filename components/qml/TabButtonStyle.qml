import QtQuick 1.0

ButtonStyle {

    buttonWidth: !parent ? 0 : parent.width / parent.children.length
    buttonHeight: 50

    background: "image://theme/ButtonGroupHorizontalMiddleNormal"
    pressedBackground: "image://theme/ButtonGroupHorizontalMiddlePressed"
    disabledBackground: "image://theme/ButtonGroupHorizontalMiddleDisabled"
}
