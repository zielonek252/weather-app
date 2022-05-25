import QtQuick 2.0
import QtQuick.Controls 6.2
import QtQuick.LocalStorage 2.0 as SQL

Item {
    id: item1
    TextField {
        id: textField
        y: 227
        height: 26
        anchors.left: parent.horizontalCenter
        anchors.right: parent.horizontalCenter
        anchors.rightMargin: -1
        anchors.leftMargin: -147
        placeholderText: qsTr("Wpisz nazwe miasta")
    }
    Button {
        id: szukajMiasta
        x: 335
        y: 227
        text: qsTr("Szukaj")
        anchors.right: parent.horizontalCenter
        anchors.rightMargin: -95
        highlighted: false
        flat: true
        onClicked: {
            function miasto() {
                var db = SQL.LocalStorage.openDatabaseSync(
                            "ostatnio_wyszukane", "1,0",
                            "Baza z ostatnio wyszukanymi miastami", 1000000)

                db.transaction(function (tx) {
                    tx.executeSql(
                                'CREATE TABLE IF NOT EXISTS Miasta(Kolejnosc TEXT, nazwa TEXT)')
                    var id = tx.executeSql('SELECT * FROM Miasta')
                    var dlugosc = id.rows.length
                    tx.executeSql('INSERT INTO Miasta VALUES (?, ?)',
                                  [dlugosc + 1, textField.text.toUpperCase()])
                    console.log("liczba czegos" + textField.text)
                })
            }
            miasto()
            console.log("Przekazuje: " + textField.text)
            stack.push("Wyszukanemiasto.qml", {
                           "nazwaMiasta": textField.text
                       })
        }
    }

    ListView {
        id: listView
        y: 291
        width: 640
        model: listaOstatnioWyszukiwanych
        height: 160
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        delegate: Item {
            x: 5
            width: 80
            height: 40
            Row {
                id: row1
                spacing: 10
                Button {
                    id: button
                    x: parent.width / 2
                    y: -19
                    width: 242
                    height: 26
                    text: name
                    onClicked: {

                    }
                }
            }
        }
    }
    ListModel {
        id: listaOstatnioWyszukiwanych
        Component.onCompleted: {

            function wyswietlBaze() {
                var db = SQL.LocalStorage.openDatabaseSync(
                            "ostatnio_wyszukane", "1,0",
                            "Baza z ostatnio wyszukanymi miastami", 1000000)

                db.transaction(function (tx) {
                    var rs = tx.executeSql(
                                'SELECT * From Miasta ORDER BY Kolejnosc DESC')
                    for (var i = 0; i < rs.rows.length; i++) {
                        listaOstatnioWyszukiwanych.append({
                                                              "name": rs.rows.item(
                                                                          i).nazwa
                                                          })
                        console.log(rs.rows.item(i).nazwa)
                    }
                })
            }
            wyswietlBaze()
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}D{i:2}D{i:3}D{i:7}
}
##^##*/

