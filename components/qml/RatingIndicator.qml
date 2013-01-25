import QtQuick 1.0

Item {
    id: root

    property int maximumValue: 5
    property double ratingValue
    property int count: -1
    property Style platformStyle: RatingIndicatorStyle {}

    height: Math.max(platformStyle.indicatorHeight, platformStyle.textFontSize)
    width: row.width + platformStyle.textSpacing + text.width

    Row {
        id: row

        height: parent.height
        anchors { left: parent.left; verticalCenter: parent.verticalCenter }

        Repeater {
            model: maximumValue

            Image {
                id: image

                width: platformStyle.indicatorWidth
                height: platformStyle.indicatorHeight
                source: platformStyle.indicatorImageSource
                sourceSize.width: width
                sourceSize.height: height
                smooth: true
                opacity: index < Math.round(ratingValue) ? 1 : 0.3
            }
        }
    }

    Label {
        id: text
        visible: count >= 0
        text: "(" + count + ")"
        color: platformStyle.disabledTextColor
        font.pixelSize: root.platformStyle.textFontSize
        anchors { left: row.right; leftMargin: root.platformStyle.textSpacing; verticalCenter: parent.verticalCenter }
    }
}
