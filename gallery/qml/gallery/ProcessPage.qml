import QtQuick 1.0
import org.hildon.components 1.0

Page {
    id: root

    title: qsTr("Process page")

    Process {
        id: process

        workingDirectory: "/home/user"
        onError: resultLabel.text = "<font color='red'>" + qsTr("Error") + "</font>"
        onFinished: resultLabel.text = process.readAllStandardOutput()
    }

    Column {
        id: column

        spacing: platformStyle.paddingNormal

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            margins: platformStyle.paddingNormal
        }

        SelectionButton {
            width: commandEdit.width
            text: qsTr("Working directory")
            valueText: process.workingDirectory
            platformIconId: "general_folder"
            onClicked: fileBrowser.open()
        }

        Label {
            text: qsTr("Command") + ":"
        }

        Flow {
            width: column.width
            spacing: platformStyle.paddingNormal

            TextField {
                id: commandEdit

                width: screen.inPortrait ? parent.width : parent.width - startButton.width - stopButton.width - (platformStyle.paddingNormal * 2)
                text: "echo hello world"
                onTextChanged: process.command = text
            }

            Button {
                id: startButton

                text: qsTr("Start")
                enabled: process.state === Processes.NotRunning
                onClicked: process.start()
            }

            Button {
                id: stopButton

                text: qsTr("Cancel")
                enabled: process.state === Processes.Running
                onClicked: process.terminate()
            }

        }

        Label {
            text: qsTr("Result") + ":"
        }
    }

    Flickable {
        id: flicker

        anchors {
            top: column.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            margins: platformStyle.paddingNormal
        }
        clip: true
        contentHeight: resultLabel.height + platformStyle.paddingNormal

        Label {
            id: resultLabel

            width: parent.width
            wrapMode: Text.WordWrap
            color: "green"
        }
    }

    ScrollDecorator {
        flickableItem: flicker
    }

    FileBrowserDialog {
        id: fileBrowser

        onAccepted: process.workingDirectory = folder
    }
}
