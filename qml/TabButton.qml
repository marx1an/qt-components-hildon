import QtQuick 1.0

Button {
    id: root

    property Item tab
    property Item __tabGroup: tab !== null ? tab.parent : null

    platformStyle: TabButtonStyle {}
    checkable: true
    __exclusive: true
    width: platformStyle.buttonWidth
    height: platformStyle.buttonHeight
    Component.onCompleted: if ((__tabGroup) && (__tabGroup.currentTab)) checked = __tabGroup.currentTab === tab;

    Connections {
        target: __tabGroup
        onCurrentTabChanged: checked = __tabGroup.currentTab === tab;
    }

    onClicked: if (tab) __tabGroup.currentTab = tab;
}
