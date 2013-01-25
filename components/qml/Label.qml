import QtQuick 1.0

Text {
    property Style platformStyle: LabelStyle {}
    property int maximumLineCount: -1

    function __clipText() {
        height = maximumLineCount * (font.pixelSize * 1.3);
        clip = true;
    }

    color: platformStyle.textColor
    font.family: platformStyle.fontFamily
    font.pixelSize: platformStyle.fontSizeNormal
    onTextChanged: if (maximumLineCount > 0 ) __clipText();
}
