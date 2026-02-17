pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    readonly property string time: Qt.formatDateTime(clock.date, "hh:mm:ss")

    property var secondsSubscribers: new Set()

    function requireSecondPrecision(component) {
        secondsSubscribers.add(component);
        updatePrecision();
    }

    function releaseSecondPrecision(component) {
        secondsSubscribers.delete(component);
        updatePrecision();
    }

    function updatePrecision() {
        clock.precision = secondsSubscribers.size > 0 ? SystemClock.Seconds : SystemClock.Minutes;
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
