import QtQuick 1.0

Item {
    id: root

    signal pressAndHold
    signal clicked

    width: screen.inPortrait ? 150 : 200
    height: 56

    Image {
        id: separator

        anchors { top: parent.top; bottom: parent.bottom; right: parent.right }
        source: "image://theme/wmSeparator"
    }

    Label {
        id: timeLabel

        anchors { left: parent.left; leftMargin: platformStyle.paddingNormal; verticalCenter: parent.verticalCenter }
        verticalAlignment: Text.AlignVCenter
        text: system.currentTimeString
    }

    Image {
        id: batteryIndicator

        property variant levels: [100, 88, 75, 63, 50, 38, 25, 13]

        function __setIndicator() {
            var i = 0;
            var set = false;

            while ((!set) && (i < levels.length)) {
                set = system.batteryLevel >= levels[i];

                if (set) {
                    source = "image://theme/icon/statusarea_battery_full" + levels[i];
                }

                i++;
            }

            if (!set) {
                source = "image://theme/icon/statusarea_battery_low";
            }
        }

        width: 32
        height: 32
        anchors { right: parent.right; rightMargin: platformStyle.paddingNormal; verticalCenter: parent.verticalCenter }
        source: "image://theme/icon/statusarea_battery_full100"
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        onPressAndHold: root.pressAndHold()
        onClicked: root.clicked()
    }

    Connections {
        target: system
        onBatteryLevelChanged: batteryIndicator.__setIndicator()
    }
}
