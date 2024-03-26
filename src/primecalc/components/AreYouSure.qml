import QtQuick
import QtQuick.Controls

ApplicationWindow {
    id: startDialog

    minimumHeight: 500
    minimumWidth: 400
    modality: Qt.ApplicationModal
    title: "Foobar"
    visible: true

    footer: DialogButtonBox {
        standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel
    }

    Rectangle {
        anchors.margins: appWindow.margin

        Text {
            text: "Are you <i>really</i> sure you want to start the computation?\nNote that the algorithm is really bad."
        }
    }
}
