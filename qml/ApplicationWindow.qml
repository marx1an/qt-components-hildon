import QtQuick 1.0
import "." 1.0

Item {
    id: appWindow

    default property alias blurChildren: blurItem.children
    property bool inPortrait: screen.inPortrait
    property Style platformStyle: PageStackWindowStyle {}


    function __blur() {
        if (blurItem.effect == null) {
            if (theme.desaturation === Desaturation.Blurred) {
                blurItem.effect = Qt.createQmlObject("BlurEffect {}", blurItem);
            }
            else {
                blurItem.effect= Qt.createQmlObject("DesaturateEffect {}", blurItem);
            }
        }
        else {
            blurItem.keepBlur = true;
        }
    }

    function __deBlur() {
        if (!blurItem.keepBlur) {
            blurItem.effect = null;
        }

        blurItem.keepBlur = false;
    }

    objectName: "__appWindow"

    Rectangle {
        id: background

        anchors.fill: parent
        color: platformStyle.backgroundColor
    }

    Image {
        id: backgroundImage

        anchors.fill: parent
        fillMode: platformStyle.backgroundFillMode
        source: screen.inPortrait ? platformStyle.portraitBackground : platformStyle.landscapeBackground
    }

    Item {
        id: blurItem

        property bool keepBlur: false // Prevent de-blurring when another popup is appearing

        anchors.fill: parent
    }

    MouseArea {
        id: globalMouseArea

        /* Used for positioning of context menu objects */

        z: Number.MAX_VALUE
        objectName: "__globalMouseArea"
        anchors.fill: parent
        onPressed: mouse.accepted = false
    }
}
