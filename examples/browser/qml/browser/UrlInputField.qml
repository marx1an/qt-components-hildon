import QtQuick 1.0
import org.hildon.components 1.0

TextField {
    id: root

    Image {
        id: progressIndicator

        width: !visible ? 0 : Math.floor((parent.width * currentTab.progress) - (platformStyle.paddingNormal * 2))
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            leftMargin: platformStyle.paddingNormal
        }

        source: "image://theme/TextInputProgress"
        visible: (currentTab !== null) && (currentTab.progress < 1)
    }
}
