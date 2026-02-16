import Quickshell
import Quickshell.Io
import QtQuick

Scope {
    id: root
    property string time

    Text {
        // anchors {
        //     // horizontalCenter: parent.horizontalCenter
        //     // top: parent.top
        //     // topMargin: 3
        //     //
        //     // fill: parent
        // }
        // anchors.centerIn: parent
        anchors.fill: parent

        color: "black"
        text: "Testing testing testing testing"
        font.pointSize: 32
        // text: root.time
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
