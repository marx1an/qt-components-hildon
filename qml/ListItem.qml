import QtQuick 1.0

Item {
    id: root

    property bool checkable: false
    property bool isChecked: false
    default property alias content: content.children

    signal pressAndHold
    signal clicked

    width: !parent ? 0 : parent.width
    height: 100

    Image {
        id: background

        z: -1
        anchors.fill: parent
        smooth: true
        source: (mouseArea.pressed) || (root.isChecked) || ((root.ListView.view) && (root.ListView.view.currentIndex === index)) ? "image://theme/TouchListBackgroundPressed" : "image://theme/TouchListBackgroundNormal"
    }

    Item {
        id: content

        anchors { left: parent.left; right: check.visible ? check.left : parent.right; top: parent.top; bottom: parent.bottom }
    }

    Image {
        id: check

        height: Math.min(sourceSize.height, root.height / 2)
        width: height
        anchors { right: parent.right; rightMargin: 16; verticalCenter: parent.verticalCenter }
        smooth: true
        source: "image://theme/icon/widgets_tickmark_list"
        visible: root.isChecked
    }

    MouseArea {
        id: mouseArea

        z: -1
        anchors.fill: parent
        onPressAndHold: root.pressAndHold()
        onClicked: root.clicked()
    }
}
