import QtQuick 1.1
import org.hildon.components 1.0

Page {
    id: page

    title: qsTr("Text input")

    Column {
        id: column

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            margins: platformStyle.paddingNormal
        }

        TextField {
            id: textField

            width: parent.width
            placeholderText: qsTr("A TextField")
        }

        SearchTextField {
            id: searchTextField
            width: parent.width
            placeholderText: qsTr("Search")
        }

        TextArea {
            id: textArea

            width: parent.width
            height: 200
            text: qsTr("A TextArea")
        }
    }
}
