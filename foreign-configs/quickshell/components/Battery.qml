import QtQuick
import "../singletons"

Text {
    id: root

    property string prefix: BatteryService.isCharging ? "󰂄" : " "
    text: prefix + BatteryService.percentage + "%"
}
