import QtQuick 1.0
import "Utils.js" as Utils

Item {
    id: root

    property alias content: content.children
    property int timeOut: 3000
    property bool interactive: false
    property string __portraitString: screen.inPortrait ? "Portrait" : ""

    signal clicked

    function open() {
        root.state = "open";
    }

    function close() {
        root.state = "closed";
    }

    z: Number.MAX_VALUE
    height: background.height
    visible: z >= 0
    anchors { left: !parent ? undefined : parent.left; right: !parent ? undefined : parent.right; bottom: !parent ? undefined : parent.top }

    Component.onCompleted: root.parent = Utils.findRootItem(root)

    Behavior on opacity { NumberAnimation { duration: 200 } }

    Image {
        id: background

        height: Math.max(50, content.height + platformStyle.paddingLarge * 2)
        anchors { left: parent.left; right: parent.right; verticalCenter: parent.verticalCenter }
        source: "image://theme/wmBanner" + root.__portraitString
        fillMode: Image.Stretch
        smooth: true
        opacity: theme.infoBannerOpacity
    }

    Item {
        id: content

        height: childrenRect.height
        anchors { left: parent.left; leftMargin: platformStyle.paddingLarge; right: parent.right; rightMargin: platformStyle.paddingLarge; verticalCenter: parent.verticalCenter }
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        enabled: root.interactive
        onClicked: root.clicked()
    }

    Timer {
        id: timer

        interval: root.timeOut
        running: root.state == "open"
        onTriggered: root.close()
    }

    states: [
        State {
            name: "open"
            AnchorChanges { target: root; anchors { top: parent.top; bottom: undefined } }
            PropertyChanges { target: root; anchors.topMargin: 56 }
        },

        State {
            name: "closed"
            extend: ""
            PropertyChanges { target: root; opacity: 0 }
        }
    ]

    transitions: Transition {
            AnchorAnimation { duration: 200; easing.type: Easing.InOutQuad }
        }
}
