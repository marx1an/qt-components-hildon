import QtQuick 1.1

Item {
    id: root

    property bool checkable: false
    property bool checked: false
    property alias text: label.text
    property alias textAlignment: label.horizontalAlignment

    signal pressAndHold
    signal clicked

    width: !parent ? 0 : parent.width
    height: 64

    Image {
        id: background

        z: -1
        anchors.fill: parent
        smooth: true
        source: (mouseArea.pressed) || (root.checked) || ((root.ListView.view) && (root.ListView.view.currentIndex === index)) ? "image://theme/TouchListBackgroundPressed" : "image://theme/TouchListBackgroundNormal"
    }

    Label {
        id: label

        anchors {
            left: parent.left
            leftMargin: (root.checkable) && (label.horizontalAlignment == Text.AlignHCenter) ? check.width + (platformStyle.paddingLarge * 2) : platformStyle.paddingLarge
            right: root.checkable ? check.left : parent.right
            rightMargin: platformStyle.paddingLarge
            verticalCenter: parent.verticalCenter
        }
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Image {
        id: check

        height: Math.min(sourceSize.height, root.height / 2)
        width: height
        anchors { right: parent.right; rightMargin: 16; verticalCenter: parent.verticalCenter }
        smooth: true
        source: root.checked ? "image://theme/icon/widgets_tickmark_list" : ""
    }

    MouseArea {
        id: mouseArea

        z: -1
        anchors.fill: parent
        onPressAndHold: root.pressAndHold()
        onClicked: root.clicked()
    }
}
