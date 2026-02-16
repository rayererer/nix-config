import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "../components"

Scope {
    id: root

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            WlrLayershell.layer: WlrLayer.Background

            color: "transparent"
            exclusionMode: ExclusionMode.Ignore

            RowLayout {
                id: row

                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                    topMargin: 3
                }

                // {{COMPONENTS_BEGIN}}
                Clock {}
                Battery {}
                // {{COMPONENTS_END}}
            }
        }
    }
}
