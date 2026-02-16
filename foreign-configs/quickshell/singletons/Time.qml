pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    property bool showSeconds: false

    readonly property string time: Qt.formatDateTime(clock.date, "hh:mm:ss")

    SystemClock {
        id: clock
        precision: root.showSeconds ? SystemClock.Seconds : SystemClock.Minutes
    }
}
