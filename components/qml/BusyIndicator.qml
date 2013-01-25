import QtQuick 1.0

Image {
    id: root

    property int __pos: 0

    source: "image://theme/wmProgressIndicator" + __pos
    smooth: true

    Timer {
        interval: 200
        running: root.visible
        repeat: true
        onTriggered: __pos < 7 ? __pos++ : __pos = 0
    }
}
