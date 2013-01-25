import QtQuick 1.0
import "." 1.0

ListView {
    id: root

    property alias filterText: filterBox.text

    Keys.forwardTo: filterBox

    Component.onCompleted: forceActiveFocus()

    FilterBox {
        id: filterBox

        z: 1000
    }
}
