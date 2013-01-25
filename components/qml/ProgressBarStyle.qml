import QtQuick 1.0

Style {
    property string size: "large" // can be 'large' or 'small'
    property string __sizeString: size == "small" ? "Small" : ""
    property url background: "image://theme/Progressbar" + __sizeString + "Background"
    property url highlight: "image://theme/Progressbar" + __sizeString
}
