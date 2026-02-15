import Quickshell
import Quickshell.Io
import QtQuick

Scope {
    id: root
    property string time

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            anchors {
                top: true
                right: true
                left: true
            }

            color: "transparent"

            exclusionMode: ExclusionMode.Ignore

            Text {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                    topMargin: 3
                }

                text: root.time
            }
        }
    }

    Process {
        id: dateProc
        command: ["date", "+%X"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.time = this.text
        }
    }

    Timer {
        interval: 500
        running: true
        repeat: true
        onTriggered: dateProc.running = true
    }
}
