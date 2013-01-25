import QtQuick 1.0

Style {
    property int titleElideMode: Text.ElideRight

    property int buttonsRightMargin: platformStyle.paddingNormal
    property int buttonsBottomMargin: platformStyle.paddingSmall
    property int buttonsColumnSpacing: 10

    property url titleBackground: "image://theme/wmDialog"
    property color backgroundColor: theme.defaultBackgroundColor
}
