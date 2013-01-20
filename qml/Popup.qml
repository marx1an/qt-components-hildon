import QtQuick 1.0
import "." 1.0

FocusScope {
    id: root

    signal opened
    signal closed

    property int status: DialogStatus.Closed
    property alias modal: fader.modal

    function open() {
        fader.open();
        root.opened();

        if (root.objectName == "__menu") {
            stateGroup.state = "openMenu";
        }
        else if (root.objectName == "__dialog") {
            stateGroup.state = "openDialog";
        }
        else if ((root.objectName == "__contextMenu") || (root.objectName == "__infoNote")) {
            stateGroup.state = "openContextMenu";
        }
    }

    function close() {
        fader.close();
        stateGroup.state = "";
        root.closed();
    }

    function __blur() {
        if (theme.desaturation === Desaturation.Blurred) {
            root.effect = Qt.createQmlObject("BlurEffect {}", root);
        }
        else {
            var blurless = Qt.createQmlObject("DesaturateEffect {}", root);

            if (theme.desaturation === Desaturation.BlurlessFullColor) {
                blurless.strength = 0.3;
            }

            root.effect = blurless;
        }
    }

    function __deBlur() {
        var ef = root.effect;
        root.effect = null;

        if (ef) {
            ef.destroy();
        }
    }

    visible: false
    onOpened: {
        visible = true;
        forceActiveFocus();
    }
    onClosed: if (pageStack.currentPage !== null) pageStack.currentPage.forceActiveFocus();

    QtObject {
        id: parentCache

        property QtObject oldParent: null
    }

    Component.onCompleted: {
        parentCache.oldParent = root.parent;
        fader.parent = root.parent;
        root.parent = fader;
    }

    Component.onDestruction: {
        if (parentCache.oldParent !== null) {
            root.parent = parentCache.oldParent
            fader.parent = root
        }
    }

    Fader {
        id: fader

        showMinimizeButton: root.objectName == "__dialog"
        onClicked: root.close()
    }

    MouseArea {
        z: -1
        anchors.fill: parent
    }

    StateGroup {
        id: stateGroup

        state: ""
        states: [
            State {
                name: "openMenu"
                AnchorChanges { target: root; anchors { top: parent.top; bottom: undefined } }
            },

            State {
                name: "openContextMenu"
                PropertyChanges { target: root; z: 1000 }
            },

            State {
                name: "openDialog"
                AnchorChanges { target: root; anchors { bottom: parent.bottom; top: undefined } }
            }
        ]

        transitions: [
            Transition {
                from: ""
                SequentialAnimation {
                    ScriptAction { script: root.status = DialogStatus.Opening }
                    AnchorAnimation { duration: theme.popupDurationIn; easing.type: Easing.InOutQuad }
                    ScriptAction { script: root.status = DialogStatus.Open }
                }
            },

            Transition {
                to: ""
                SequentialAnimation {
                    ScriptAction { script: root.status = DialogStatus.Closing }
                    AnchorAnimation { duration: theme.popupDurationOut; easing.type: Easing.InOutQuad }
                    ScriptAction { script: root.status = DialogStatus.Closed }
                }
            }
        ]
    }
}
