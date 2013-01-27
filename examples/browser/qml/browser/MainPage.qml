import QtQuick 1.0
import org.hildon.components 1.0
import "CreateObject.js" as ObjectCreator

Page {
    id: root

    property alias tabs: tabGroup.children
    property alias currentTab: tabGroup.currentTab
    property alias tabGroup: tabGroup

    title: (tabGroup.currentTab === null) || (!tabGroup.currentTab.title) ? qsTr("Browser") : tabGroup.currentTab.title
    tools: MenuLayout {

        MenuItem {
            text: qsTr("View tabs")
            onClicked: pageStack.push(Qt.resolvedUrl("TabsPage.qml"))
        }

        MenuItem {
            text: qsTr("New tab")
            onClicked: tabGroup.addTab()
        }

        MenuItem {
            text: qsTr("Reload")
            onClicked: tabGroup.currentTab.reload.trigger()
            visible: tabGroup.currentTab !== null
        }

        MenuItem {
            text: qsTr("Close tab")
            onClicked: tabGroup.currentTab.destroy()
            visible: tabGroup.currentTab !== null
        }

        MenuItem {
            text: qsTr("Settings")
            onClicked: {
                loader.sourceComponent = settingsDialog;
                loader.item.open();
            }
        }

        MenuItem {
            text: qsTr("About")
            onClicked: {
                loader.sourceComponent = aboutDialog;
                loader.item.open();
            }
        }
    }

    TabGroup {
        id: tabGroup

        function addTab(url) {
            var tab = ObjectCreator.createObject(Qt.resolvedUrl("BrowserTab.qml"), tabGroup);
            tabGroup.currentTab = tab;
            urlInput.text = "";
            tab.urlChanged.connect(urlInput.setUrl(url));

            if (url) {
                tab.url = url;
            }
        }

        anchors.fill: parent
    }

    ToolBar {
        id: toolBar

        height: 80
        visible: !appWindow.fullScreen
        platformStyle: ToolBarStyle {
            background: "image://theme/ToolbarSecondaryBackground"
        }

        ToolBarLayout {

            ToolButton {
                width: 80
                height: 80
                platformIconId: "general_backspace"
                onClicked: tabGroup.currentTab.back.trigger()
            }

            ToolButton {
                width: 80
                height: 80
                platformIconId: "general_add"
                onClicked: {
                    loader.sourceComponent = bookmarkDialog;
                    loader.item.name = tabGroup.currentTab.title === "" ? tabGroup.currentTab.url : tabGroup.currentTab.title;
                    loader.item.address = tabGroup.currentTab.url;
                    loader.item.open();
                }
            }

            UrlInputField {
                id: urlInput

                function setUrl(url) {
                    if (url) {
                        urlInput.text = url;
                        urlInput.cursorPosition = 0;
                    }
                }

                function urlFromTextInput(url) {
                    if (url === "") {
                        return url;
                    }
                    if (url[0] === "/") {
                        return "file://" + url;
                    }
                    if (url.indexOf(":") < 0) {
                        if ((url.indexOf(".") < 0) || (url.indexOf(" ") >= 0)) {
                            return "http://google.com/search?q=" + url;
                        }
                        else {
                            return "http://" + url;
                        }
                    }

                    return url;
                }

                height: 80
                width: screen.inPortrait ? stopButton.visible ? 80 : 170 : stopButton.visible ? 400 : 470
                onAccepted: {
                    if (tabGroup.currentTab) {
                        tabGroup.currentTab.url = urlInput.urlFromTextInput(urlInput.text);
                    }
                    else {
                        tabGroup.addTab(urlInput.urlFromTextInput(urlInput.text));
                    }
                }

                onActiveFocusChanged: if (urlInput.activeFocus) urlInput.selectAll();
            }

            ToolButton {
                id: stopButton

                width: 80
                height: 80
                platformIconId: "general_stop"
                visible: (tabGroup.currentTab !== null) && (tabGroup.currentTab.progress < 1)
                onClicked: tabGroup.currentTab.stop.trigger()
            }

            ToolButton {
                width: 80
                height: 80
                platformIconId: "general_mybookmarks_folder"
                onClicked: pageStack.push(Qt.resolvedUrl("BookmarksPage.qml"))
            }

            ToolButton {
                width: 80
                height: 80
                platformIconId: "general_fullsize"
                enabled: tabGroup.currentTab !== null
                onClicked: appWindow.fullScreen = true
            }
        }
    }

    ToolButton {
        width: 90
        height: 90
        anchors {
            right: parent.right
            bottom: parent.bottom
            margins: -10
        }
        platformIconId: "general_fullsize"
        visible: timer.running
        onClicked: appWindow.fullScreen = false
        platformStyle: ToolButtonStyle {
            background: "toolbutton_background.png"
            pressedBackground: "toolbutton_background.png"
        }

        Timer {
            id: timer

            running: (appWindow.fullScreen) && (tabGroup.currentTab !== null) && (!tabGroup.currentTab.moving)
            interval: 3000
        }
    }

    Component {
        id: settingsDialog

        SettingsDialog {}
    }

    Component {
        id: bookmarkDialog

        NewBookmarkDialog {}
    }

    Component {
        id: aboutDialog

        QueryDialog {
            modal: false
            icon: "image://theme/icon/general_web"
            titleText: qsTr("About")
            message: qsTr("A simple web browser written using Qt Components Hildon. Includes support for tabbed browsing and bookmarks.")
            acceptButtonText: qsTr("Done")
        }
    }

    Loader {
        id: loader
    }
}
