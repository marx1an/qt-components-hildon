import QtQuick 1.0

Item {
    id: root

    property double value: 0.0
    property int minimumValue: 0
    property int maximumValue: 1
    property Style platformStyle: ProgressBarStyle {}

    width: 150
    height: platformStyle.size === "small" ? 16 : 70

    BorderImage {
        id: background

        anchors.fill: parent
        border { left: platformStyle.paddingSmall; right: platformStyle.paddingSmall }
        smooth: true
        source: platformStyle.background
    }

    BorderImage {
        id: highlight

        anchors { left: parent.left; top: parent.top; bottom: parent.bottom; margins: 3 }
        border { left: platformStyle.paddingSmall; right: platformStyle.paddingSmall }
        width: root.value <= root.minimumValue ? 0 : Math.floor((parent.width * root.value) * (root.maximumValue - root.minimumValue)) - 6
        smooth: true
        source: platformStyle.highlight
    }

    Label {
        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: Math.floor((root.value * (root.maximumValue - root.minimumValue)) * 100) + "%"
        visible: (root.platformStyle.size !== "small") && (root.width > width)
    }
}
