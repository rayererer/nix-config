pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property int percentage

    Process {
        id: batteryProcess

        command: ["cat", "/sys/class/power_supply/BAT0/capacity"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.percentage = this.text
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: batteryProcess.running = true
    }
}
