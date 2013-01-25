import QtQuick 1.0

Item {

    property Item currentTab

    width: parent ? parent.width : 0
    height: parent ? parent.height : 0

    onVisibleChanged: __update()
    onChildrenChanged: __update()
    onCurrentTabChanged: __update()

    function __update() {
        for (var i = 0; i < children.length; i++) {
            var child = children[i];
            var newVis = child == currentTab;
            if (child.visible != newVis) {
                child.visible = newVis;
//                if (child.status !== undefined) {
//                    if (newVis) {
//                        child.status = PageStatus.Activating;
//                        child.status = PageStatus.Active;
//                    } else {
//                        child.status = PageStatus.Deactivating;
//                        child.status = PageStatus.Inactive;
//                    }
//                }
            }
        }
    }

}
