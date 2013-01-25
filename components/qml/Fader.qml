import QtQuick 1.0
import "." 1.0
import "Utils.js" as Utils

Item {
    id: root

    property bool enabled: false
    property bool modal: false
    property bool showMinimizeButton: true
    property Item originalParent: parent
    property Item visualParent: null

    signal clicked

    function open() {
        root.state = "visible";
    }

    function close() {
        root.state = "hidden";
    }

    z: 1000
    width: screen.width
    height: screen.height
    state: "hidden"

    Image {
        id: background

        anchors.fill: parent
        source: (theme.enableDesaturationEffects) && (theme.desaturation !== Desaturation.BlurlessFullColor) ? "" : "fader.png"
    }

    PopupMinimizeButton {
        z: Number.MAX_VALUE
        anchors { top: parent.top; left: parent.left }
        visible: root.showMinimizeButton
    }

    MouseArea {
        id: mouseArea

        width: screen.width
        height: screen.height
        enabled: root.enabled
        onClicked: {
            if (!root.modal) {
                root.close();
                root.clicked();
            }
        }
    }

    states: [
        State {
            name: "hidden"
            PropertyChanges { target: root; enabled: false; opacity: 0 }
        },

        State {
            name: "visible"
            PropertyChanges { target: root; enabled: true; opacity: 1 }
        }
    ]

    transitions: [
        Transition {
            from: "hidden"
            to: "visible"
            SequentialAnimation {
                ScriptAction { script: {
                        root.originalParent = root.parent;
                        var rootItem = Utils.findRootItem(root);

                        if (rootItem !== null) {
                            root.parent = rootItem;
                        }
                        else {
                            root.parent = root.originalParent;
                        }

                        root.visualParent = Utils.findVisualDialogParent(root.originalParent);

                        if (root.visualParent !== null) {
                            if ((theme.enableDesaturationEffects) && (theme.desaturation !== Desaturation.BlurlessFullColor) && (root.visualParent.hasOwnProperty("__blur"))) {
                                root.visualParent.__blur();
                            }
                            else {
                                background.parent = root.visualParent;
                            }
                        }
                    }
                }
                NumberAnimation { properties: "opacity"; from: 0; to: 1; duration: 200 }
            }
        },

        Transition {
            from: "visible"
            to: "hidden"
            SequentialAnimation {
                NumberAnimation { properties: "opacity"; from: 1; to: 0; duration: 200 }
                ScriptAction { script: {
                        if ((theme.enableDesaturationEffects) && (theme.desaturation !== Desaturation.BlurlessFullColor) && (root.visualParent.hasOwnProperty("__deBlur"))) {
                            root.visualParent.__deBlur();
                        }
                        else {
                            background.parent = root;
                        }

                        root.parent = root.originalParent;
                    }
                }
            }
        }
    ]
}
