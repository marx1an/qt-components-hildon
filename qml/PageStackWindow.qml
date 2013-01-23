import QtQuick 1.0
import "." 1.0

Item {
    id: appWindow

    property bool inPortrait: screen.inPortrait
    property bool fullScreen: false
    property alias pageStack: stack
    property alias windowTitle: statusBar.titleText
    property Item initialPage: null
    property bool busy: false
    property Style platformStyle: PageStackWindowStyle {}


    function __blur() {
        if (blurItem.effect == null) {
            if (theme.desaturation === Desaturation.Blurred) {
                blurItem.effect = Qt.createQmlObject("BlurEffect {}", blurItem);
            }
            else {
                blurItem.effect= Qt.createQmlObject("DesaturateEffect {}", blurItem);
            }
        }
        else {
            blurItem.keepBlur = true;
        }
    }

    function __deBlur() {
        if (!blurItem.keepBlur) {
            blurItem.effect = null;
        }

        blurItem.keepBlur = false;
    }

    objectName: "__appWindow"

    Component.onCompleted: if (initialPage !== null) stack.push(initialPage, undefined, true);

    Rectangle {
        id: background

        anchors.fill: parent
        color: platformStyle.backgroundColor
    }

    Image {
        id: backgroundImage

        anchors.fill: parent
        fillMode: platformStyle.backgroundFillMode
        source: screen.inPortrait ? platformStyle.portraitBackground : platformStyle.landscapeBackground
    }

    Item {
        id: blurItem

        property bool keepBlur: false // Prevent de-blurring when another popup is appearing

        anchors.fill: parent

        PageStack {
            id: stack

            anchors { fill: parent; topMargin: statusBar.visible ? statusBar.height : 0 }
            onCurrentPageChanged: if (currentPage !== null) currentPage.forceActiveFocus();
        }

        StatusBar {
            id: statusBar

            property string backPressedState: backButtonPressed ? "Pressed" : ""

            titleText: appWindow.windowTitle
            visible: !appWindow.fullScreen
            showBusyIndicator: appWindow.busy
            showMenuIndicator: (pageStack.currentPage !== null) && (pageStack.currentPage.tools !== null)
            backButtonIconSource: (pageStack === null) || (pageStack.depth === 1) ? "image://theme/wmCloseIcon" + backPressedState : "image://theme/wmBackIcon" + backPressedState
            onTitleAreaClicked: menu.open()
            onBackClicked: (pageStack === null) || (pageStack.depth === 1) ? Qt.quit() : pageStack.pop()
            onBackPressAndHold: if ((pageStack !== null) && (pageStack.depth > 1)) pageStack.pop(null);
        }
    }

    Menu {
        id: menu

        tools: pageStack.currentPage === null ? null : pageStack.currentPage.tools
        visible: (pageStack.currentPage !== null) && (pageStack.currentPage.tools !== null)
    }

    MouseArea {
        id: globalMouseArea

        /* Used for positioning of context menu objects */

        z: Number.MAX_VALUE
        objectName: "__globalMouseArea"
        anchors.fill: parent
        onPressed: mouse.accepted = pageStack.busy
    }
}
