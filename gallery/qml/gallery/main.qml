import QtQuick 1.0
import org.hildon.components 1.0

PageStackWindow {
    id: appWindow

    initialPage: HomePage {
        id: homePage
    }

    InfoBanner {
        id: infoBanner

        function showMessage(message) {
            label.text = message;
            infoBanner.open();
        }

        content: Label {
            id: label

            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: theme.notificationTextColor
        }
    }

    InfoNote {
        id: infoNote
    }
}
