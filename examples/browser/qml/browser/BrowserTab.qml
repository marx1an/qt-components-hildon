import QtQuick 1.0
import QtWebKit 1.0
import org.hildon.components 1.0

Item {
    id: root

    property alias url: view.url
    property alias title: view.title
    property alias icon: view.icon
    property alias javaScriptWindowObjects: view.javaScriptWindowObjects
    property alias newWindowComponent: view.newWindowComponent
    property alias newWindowParent: view.newWindowParent
    property alias preferredHeight: view.preferredHeight
    property alias preferredWidth: view.preferredWidth
    property alias pressGrabTime: view.pressGrabTime
    property alias back: view.back
    property alias forward: view.forward
    property alias reload: view.reload
    property alias stop: view.stop
    property alias progress: view.progress
    property alias interactive: flicker.interactive
    property alias moving: flicker.moving

    signal loadStarted
    signal loadFinished
    signal loadFailed
    signal urlChanged

    anchors.fill: !parent ? undefined : parent

    Keys.onPressed: {
        if (event.key === Qt.Key_Up) {
            if (event.modifiers & Qt.ShiftModifier) {
                flicker.contentY = 0;
            }
            else if (!flicker.atYBeginning) {
                flicker.contentY -= 20;
            }
        }
        else if (event.key === Qt.Key_Down) {
            if (event.modifiers & Qt.ShiftModifier) {
                flicker.contentY = (flicker.contentHeight - flicker.height);
            }
            else if (!flicker.atYEnd) {
                flicker.contentY += 20;
            }
        }
        else if ((event.key === Qt.Key_Left) && (!flicker.atXBeginning)) {
            flicker.contentX -= 20;
        }
        else if ((event.key === Qt.Key_Right) && (!flicker.atXEnd)) {
            flicker.contentX += 20;
        }
    }

    Flickable {
        id: flicker

        anchors.fill: parent
        contentWidth: view.contentsSize.width
        contentHeight: view.contentsSize.height
        interactive: true

        WebView {
            id: view

            anchors.fill: parent
            onLoadStarted: root.loadStarted()
            onLoadFinished: root.loadFinished()
            onLoadFailed: root.loadFailed()
            onUrlChanged: root.urlChanged()
        }
    }

    ScrollDecorator {
        flickableItem: flicker
    }
}
