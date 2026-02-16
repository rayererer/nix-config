import Quickshell
import QtQuick
import QtQuick.Layouts
import "../components"
import "../singletons"

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

            color: "transparent"
            exclusionMode: ExclusionMode.Ignore

            RowLayout {
                anchors {
                    fill: parent
                }

                // {{COMPONENTS_BEGIN}}
                Clock {
                    time: Time.time
                }
                Battery {}
                // {{COMPONENTS_END}}
            }
        }
    }
}
