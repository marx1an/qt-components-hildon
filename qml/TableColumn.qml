import QtQuick 1.0

QtObject {
    property string title
    property string role
    property int width: 160
    property int x
    property bool visible: true
    property int textAlignment: Text.AlignHCenter
    property Component delegate
}
