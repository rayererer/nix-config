import QtQuick
import "../singletons"

Row {
    id: root
    property string suffix: BatteryService.isCharging ? "󱐋" : " "
    Text {

        text: BatteryService.percentage + "%"
    }

    Text {
        font.family: "monospace"
        text: root.suffix
    }
}
