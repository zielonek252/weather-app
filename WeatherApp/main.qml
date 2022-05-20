import QtQuick
import QtQuick.Controls 6.2

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    StackView {
        id: stack
        x: 0
        y: 0
        anchors.fill: parent
        initialItem: Qt.createComponent("Menu.qml")
    }
}
