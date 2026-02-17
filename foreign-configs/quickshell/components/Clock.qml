import QtQuick
import "../singletons"

Text {
    id: root
    property bool showSeconds: false

    function precisionUpdate() {
        showSeconds ? TimeService.requireSecondPrecision(root) : TimeService.releaseSecondPrecision(root);
    }

    Component.onCompleted: precisionUpdate()
    onShowSecondsChanged: precisionUpdate()

    Component.onDestruction: TimeService.releaseSecondPrecision(root)

    text: {
        showSeconds ? TimeService.time : TimeService.time.slice(0, -3);
    }
}
