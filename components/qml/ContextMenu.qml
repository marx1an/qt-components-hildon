import QtQuick 1.0
import "Utils.js" as Utils

Popup {
    id: root

    property MouseArea __globalMouseArea

    function __updatePosition() {
        x = Math.min(__globalMouseArea.mouseX, __globalMouseArea.width - width);
        y = Math.min(Math.abs(__globalMouseArea.mouseY - height / 2), __globalMouseArea.height - height);
    }

    z: -1
    objectName: "__contextMenu"
    enabled: visible

    Component.onCompleted: __globalMouseArea = Utils.findGlobalMouseArea(root)

    Connections {
        target: __globalMouseArea
        onPressed: if (root.z < 0) __updatePosition();
    }

    BorderImage {
        id: background

        anchors.fill: parent
        smooth: true
        border { left: 20; right: 20; top: 20; bottom: 20 }
        source: "image://theme/ContextMenu"
    }    
}
