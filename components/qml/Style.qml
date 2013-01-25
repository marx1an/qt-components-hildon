import QtQuick 1.0

QtObject {
    id: style

    property string fontFamily: theme.fontFamily
    property int fontSizeSmall: theme.fontSizeSmall
    property int fontSizeNormal: theme.fontSizeNormal
    property int fontSizeLarge: theme.fontSizeLarge
    property int fontSizeXLarge: theme.fontSizeXLarge
    property int fontSizeXXLarge: theme.fontSizeXXLarge
    property int fontSizeXXXLarge: theme.fontSizeXXXLarge
    property int fontCapitalization: Font.MixedCase
    property int fontWeight: Font.Normal
    property int horizontalAlignment: Text.AlignHCenter
    property int elideMode: Text.ElideNone
    property int paddingXSmall: 6
    property int paddingSmall: 10
    property int paddingNormal: 16
    property int paddingLarge: 22
    property int paddingXLarge: 28
    property int paddingXXLarge: 36
    property int paddingXXXLarge: 48
}
