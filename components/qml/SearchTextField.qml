import QtQuick 1.0

TextField {
    id: root

    placeholderText: qsTr("Search")
    inputMethodHints: Qt.ImhNoPredictiveText | Qt.ImhNoAutoUppercase
    platformStyle: TextFieldStyle { paddingRight: cancelButton.width + 20 }
    onTextChanged: focus = text != ""

    Image {
        id: cancelButton

        z: 1000
        anchors { right: parent.right; rightMargin: 10; verticalCenter: parent.verticalCenter }
        source: "cancel.png"
        opacity: mouseArea.pressed ? 0.5 : 1
        visible: root.text != ""

        MouseArea {
            id: mouseArea

            width: 60
            height: 60
            anchors.centerIn: parent
            onClicked: {
                root.focus = false;
                root.text = "";
                root.closeSoftwareInputPanel();
            }
        }
    }
}
