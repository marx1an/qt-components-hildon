import QtQuick 1.0

FocusScope {
    id: root

    property bool enabled: true
    property bool checkable: false
    property bool __exclusive: false
    property bool checked: false
    property bool pressed: mouseArea.pressed
    property alias text: label.text
    property string platformIconId
    property alias iconSource: icon.source
    property string iconSize
    property Style platformStyle: ButtonStyle {}

    signal clicked
    signal pressAndHold
    signal checkChanged(variant button)

    objectName: "__button"
    width: platformStyle.buttonWidth
    height: platformStyle.buttonHeight

    BorderImage {
        id: background

        anchors.fill: parent
        source: !root.enabled ? platformStyle.disabledBackground : (mouseArea.pressed) || (root.checked) ? platformStyle.pressedBackground : platformStyle.background
        smooth: true
        border {
            left: platformStyle.backgroundMarginLeft
            right: platformStyle.backgroundMarginRight
            top: platformStyle.backgroundMarginTop
            bottom: platformStyle.backgroundMarginBottom
        }
    }

    Row {
        id: row

        anchors {
            left: platformStyle.horizontalAlignment == Text.AlignLeft ? parent.left : undefined
            leftMargin: platformStyle.textMarginLeft
            right: platformStyle.horizontalAlignment == Text.AlignLeft ? parent.right : undefined
            rightMargin: platformStyle.textMarginRight
            top: parent.top
            bottom: parent.bottom
            horizontalCenter: platformStyle.horizontalAlignment == Text.AlignHCenter ? parent.horizontalCenter : undefined
        }
        spacing: platformStyle.paddingSmall

        Image {
            id: icon

            width: sourceSize.width
            height: sourceSize.height
            anchors.verticalCenter: parent.verticalCenter
            source: root.platformIconId == "" ? "" : "image://theme/icon/" + root.platformIconId
            opacity: root.enabled ? 1 : 0.3
            smooth: true
            visible: source != ""
        }

        Label {
            id: label

            property int maxWidth: icon.visible ? root.width - icon.width - root.platformStyle.paddingSmall - root.platformStyle.textMarginLeft - root.platformStyle.textMarginRight : root.width - root.platformStyle.textMarginLeft - root.platformStyle.textMarginRight

            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: (icon.visible) || (width == maxWidth) ? Text.AlignLeft : Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            clip: true
            opacity: root.enabled ? 1 : 0.3
            visible: text != ""
            onMaxWidthChanged: paintedWidth > maxWidth ? width = maxWidth : width = paintedWidth
            onPaintedWidthChanged: paintedWidth > maxWidth ? width = maxWidth : width = paintedWidth
        }
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        enabled: root.enabled
        onPressAndHold: root.pressAndHold()
        onClicked: {
            if (root.checkable) {
                if ((root.__exclusive) || (!root.checked)) {
                    root.checked = true;
                }
                else {
                    root.checked = !root.checked;
                }

                root.checkChanged(root);
            }

            root.clicked();
        }
    }
}
