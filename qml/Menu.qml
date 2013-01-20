import QtQuick 1.0

Popup {
    id: root

    property Item tools: pageStack.currentPage === null ? null : pageStack.currentPage.tools
    property Item toolsParent // Pointer to the original parent of the tools
    property Style platformStyle: MenuStyle {}

    onToolsChanged: {
        if (toolsParent) {
            // Re-parent the old tools to the original parent
            for (var i = 0; i < children.length; i++) {
                if ((children[i].objectName === "__menuLayout") && (children[i] !== tools)) {
                    children[i].parent = toolsParent;
                }
            }
        }

        if (tools) {
            toolsParent = tools.parent;
            tools.parent = root;
        }
    }
    anchors {
        left: !parent ? undefined : parent.left
        leftMargin: screen.inPortrait ? 0 : platformStyle.paddingXXXLarge
        right: !parent ? undefined : parent.right
        rightMargin: screen.inPortrait ? 0 : platformStyle.paddingXXXLarge
        bottom: !parent ? undefined : parent.top
    }
    height: tools === null ? 0 : tools.height + platformStyle.paddingNormal * 2
    objectName: "__menu"

    BorderImage {
        id: background

        anchors.fill: parent
        smooth: true
        border {
            left: platformStyle.backgroundMarginLeft
            right: platformStyle.backgroundMarginRight
            top: platformStyle.backgroundMarginTop
            bottom: platformStyle.backgroundMarginBottom
        }
        source: platformStyle.background
    }
}
