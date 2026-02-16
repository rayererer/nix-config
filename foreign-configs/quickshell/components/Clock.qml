import QtQuick
import "../singletons"

Text {
    id: root
    property bool showSeconds: false

    function precisionUpdate() {
        showSeconds ? Time.requireSecondPrecision(root) : Time.releaseSecondPrecision(root);
    }

    Component.onCompleted: precisionUpdate()
    onShowSecondsChanged: precisionUpdate()

    Component.onDestruction: Time.releaseSecondPrecision(root)

    text: {
        showSeconds ? Time.time : Time.time.slice(0, -3);
    }
}
