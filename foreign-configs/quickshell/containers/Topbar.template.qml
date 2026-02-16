import Quickshell
import QtQuick
import QtQuick.Layouts

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
                anchors.fill: parent
                anchors.margins: 8

                {{COMPONENTS}}
            }
        }
    }
}
