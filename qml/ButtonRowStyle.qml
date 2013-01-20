import QtQuick 1.0

ButtonStyle {
    property int buttonIndex: 1
    property int buttonRowLength

    buttonWidth: !parent ? 0 : parent.width / buttonRowLength
    background: buttonIndex == 1 ? backgroundLeft : buttonIndex == buttonRowLength ? backgroundRight : backgroundMid
    pressedBackground: buttonIndex == 1 ? backgroundLeftPressed : buttonIndex == buttonRowLength ? backgroundRightPressed : backgroundMidPressed
    disabledBackground: buttonIndex == 1 ? backgroundLeftDisabled : buttonIndex == buttonRowLength ? backgroundRightDisabled : backgroundMidDisabled

    property url backgroundLeft: "image://theme/ButtonGroupHorizontalLeftNormal"
    property url backgroundMid: "image://theme/ButtonGroupHorizontalMiddleNormal"
    property url backgroundRight: "image://theme/ButtonGroupHorizontalRightNormal"

    property url backgroundLeftPressed: "image://theme/ButtonGroupHorizontalLeftPressed"
    property url backgroundMidPressed: "image://theme/ButtonGroupHorizontalMiddlePressed"
    property url backgroundRightPressed: "image://theme/ButtonGroupHorizontalRightPressed"

    property url backgroundLeftDisabled: "image://theme/ButtonGroupHorizontalLeftDisabled"
    property url backgroundMidDisabled: "image://theme/ButtonGroupHorizontalMiddleDisabled"
    property url backgroundRightDisabled: "image://theme/ButtonGroupHorizontalRightDisabled"
}
