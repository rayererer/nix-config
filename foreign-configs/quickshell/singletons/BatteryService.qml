pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property int percentage
    property bool isCharging

    Process {
        id: percentageProcess

        command: ["cat", "/sys/class/power_supply/BAT0/capacity"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.percentage = this.text
        }
    }

    Process {
        id: chargingProcess

        command: ["cat", "/sys/class/power_supply/BAT0/status"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.isCharging = this.text === "Charging\n"
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            percentageProcess.running = true;
            chargingProcess.running = true;
        }
    }
}
