import QtQuick 1.0

Style {
    property url background: ""
    property url landscapeBackground: background
    property url portraitBackground: background
    property url portraiteBackground: background

    property color backgroundColor: theme.defaultBackgroundColor

    property int backgroundFillMode: Image.Stretch
}
