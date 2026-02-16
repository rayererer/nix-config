pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    property bool showSeconds: false

    readonly property string time: Qt.formatDateTime(clock.date, showSeconds ? "hh:mm:ss" : "hh:mm")

    SystemClock {
        id: clock
        precision: root.showSeconds ? SystemClock.Seconds : SystemClock.Minutes
    }
}
