import QtQuick
import "../singletons"

Text {
    id: root

    text: BatteryService.percentage + "%"
}
