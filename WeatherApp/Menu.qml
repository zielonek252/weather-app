import QtQuick 2.0
import QtQuick.Controls 6.2

Item {
    TextField {
        id: textField
        x: 173
        y: 227
        width: 148
        height: 26
        placeholderText: qsTr("Wpisz nazwe miasta")
    }
    Button {
        id: szukajMiasta
        x: 335
        y: 227
        text: qsTr("Szukaj")
        highlighted: false
        flat: true
        onClicked: {
            console.log("Przekazuje: " + textField.text)
            stack.push("Wyszukanemiasto.qml", {
                           "nazwaMiasta": textField.text
                       })
        }
    }
}
