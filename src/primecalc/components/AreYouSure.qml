import QtQuick
import QtQuick.Dialogs

MessageDialog {
    id: startDialog

    visible: true
    buttons: MessageDialog.Ok | MessageDialog.Cancel
    text: "Start computation?"
    informativeText: "Are you <i>really</i> sure you want to start the computation?\nNote that the algorithm is really bad."
}
