import QtQuick 1.0
import org.hildon.components 1.0

QueryDialog {
    id: root

    modal: false
    titleText: qsTr("About")
    icon: "image://theme/icon/general_device_root_folder"
    message: "<b><font size='20'>Qt Components Hildon Gallery</font></b><br><br>" + qsTr("A demonstration of Qt Components Hildon") + "<br><br> &copy; Stuart Howarth 2013"
    acceptButtonText: qsTr("Donate")
}
