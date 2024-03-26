import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "./components"

ApplicationWindow {
    id: appWindow

    readonly property int margin: 8

    minimumHeight: 200
    minimumWidth: 200
    title: "Prime Calculator"
    visible: true

    footer: DialogButtonBox {
        id: buttons

        standardButtons: DialogButtonBox.Ok | DialogButtonBox.Close

        onAccepted: {
            var component = Qt.createComponent("qml:components/AreYouSure.qml");
            if (component.status == Component.Ready) {
                component.createObject(appWindow);
            } else {
                console.log(component.errorString());
            }
            component.statusChanged.connect(() => {
                    if (component.status == Component.Ready) {
                        let object = component.createObject(appWindow);
                        object.transientParent = appWindow;
                    } else {
                        console.log(component.errorString());
                    }
                });
        }
        onRejected: appWindow.close()
    }

    ColumnLayout {
        id: mainLayout

        anchors.fill: parent
        anchors.margins: appWindow.margin

        GroupBox {
            Layout.fillWidth: true
            Layout.minimumWidth: rowLayout.Layout.minimumWidth + 30
            title: "Number to check:"

            RowLayout {
                id: rowLayout

                anchors.fill: parent
                spacing: 8

                TextField {
                    Layout.fillWidth: true
                    placeholderText: "37"

                    validator: IntValidator {
                        bottom: 2
                    }

                    onTextEdited: {
                        buttons.standardButton(DialogButtonBox.Ok).enabled = this.acceptableInput;
                    }
                }
            }
        }
    }
}
