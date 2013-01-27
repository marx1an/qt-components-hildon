import QtQuick 1.0
import org.hildon.components 1.0
import org.hildon.browser 1.0

PageStackWindow {
    id: appWindow

    property alias tabs: mainPage.tabs
    property alias tabGroup: mainPage.tabGroup
    property alias currentTab: mainPage.currentTab

    windowTitle: qsTr("Browser")
    initialPage: MainPage {
        id: mainPage
    }

    Settings {
        id: settings

        fileName: "/home/stuart/.config/QtComponentsHildon/Browser/browser.conf"
    }

    BookmarksModel {
        id: bookmarks

        fileName: "/home/stuart/.config/QtComponentsHildon/Browser/bookmarks.xml"
    }

    InfoBanner {
        id: infoBanner

        function showMessage(message) {
            infoLabel.text = message;
            infoBanner.open();
        }

        content: Label {
            id: infoLabel

            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: theme.notificationTextColor
        }
    }

    InfoNote {
        id: infoNote

        function showMessage(message) {
            noteLabel.text = message;
            infoNote.open();
        }

        content: Label {
            id: noteLabel

            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            color: theme.notificationTextColor
        }
    }
}
