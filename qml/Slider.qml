import QtQuick 1.0

Item {
    id: root

    property int orientation: Qt.Horizontal
    property bool enabled: true
    property bool bidirectional: false
    property Style platformStyle: SliderStyle {}
    property alias minimumValue: range.minimumValue
    property alias maximumValue: range.maximumValue
    property alias value: range.value

    objectName: "__slider"
    width: platformStyle.sliderWidth
    height: platformStyle.sliderHeight
    rotation: orientation == Qt.Vertical ? -90 : 0

    BorderImage {
        id: background

        anchors.fill: parent
        border {
            left: platformStyle.backgroundMarginLeft
            right: platformStyle.backgroundMarginRight
            top: platformStyle.backgroundMarginTop
            bottom: platformStyle.backgroundMarginBottom
        }
        smooth: true
        source: root.enabled ? platformStyle.background : platformStyle.backgroundDisabled
    }

    Image {
        id: leftBackground

        z: 1
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }
        smooth: true
        source: root.enabled ? platformStyle.valueBackground : platformStyle.valueBackgroundDisabled
    }

    BorderImage {
        id: highlight

        anchors {
            top: parent.top
            topMargin: -4
            bottom: parent.bottom
            bottomMargin: -5
            left: parent.left
            right: handle.left
        }
        border {
            left: platformStyle.backgroundMarginLeft
            right: platformStyle.backgroundMarginRight
            top: platformStyle.backgroundMarginTop
            bottom: platformStyle.backgroundMarginBottom
        }
        smooth: true
        source: platformStyle.highlight
    }


    Image {
        id: handle

        z: 1
        anchors.verticalCenter: parent.verticalCenter
        smooth: true
        source: root.enabled ? platformStyle.handle : platformStyle.handleDisabled
    }

    MouseArea {
        id: mouseArea

        property real oldPosition: 0

        anchors.fill: parent
        drag.target: handle
        drag.axis: Drag.XAxis
        drag.minimumX: range.positionAtMinimum
        drag.maximumX: range.positionAtMaximum

        onPressed: {
            oldPosition = range.position;
            var newX = Math.max(mouse.x - handle.width / 2, drag.minimumX);
            newX = Math.min(newX, drag.maximumX);
            range.position = newX;
        }

        onCanceled: {
            range.position = oldPosition;
        }
    }

    RangeModel {
        id: range

        minimumValue: root.bidirectional ? -50 : 0
        maximumValue: root.bidirectional ? 50 : 100
        value: 0
        positionAtMinimum: 0
        positionAtMaximum: root.width - handle.width
    }

    Binding {
        when: !mouseArea.drag.active
        target: handle
        property: "x"
        value: range.position
    }

    Binding {
        when: mouseArea.drag.active
        target: range
        property: "position"
        value: handle.x
    }

    states: State {
        name: "bidirectional"
        when: root.bidirectional
        PropertyChanges { target: leftBackground; source: ""; visible: false }
        AnchorChanges { target: highlight; anchors { left: undefined; right: undefined; horizontalCenter: parent.horizontalCenter } }
        PropertyChanges { target: highlight; width: 8; anchors { topMargin: 0; bottomMargin: 0 } source: root.enabled ? platformStyle.centerPointBackground : platformStyle.centerPointBackgroundDisabled }
    }
}
