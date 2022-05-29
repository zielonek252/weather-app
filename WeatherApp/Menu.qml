import QtQuick 2.0
import QtQuick.Controls 6.2
import QtQuick.LocalStorage 2.0 as SQL

Item {
    id: item1
    TextField {
        id: textField
        y: 195
        height: 26
        anchors.left: parent.horizontalCenter
        anchors.right: parent.horizontalCenter
        anchors.rightMargin: -74
        anchors.leftMargin: -74
        placeholderText: qsTr("Wpisz nazwe miasta")
    }
    Button {
        id: szukajMiasta
        x: 246
        y: 227
        width: 148
        height: 26
        text: qsTr("Szukaj")
        anchors.right: parent.horizontalCenter
        anchors.rightMargin: -74
        highlighted: true
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
        y: 293
        model: listaOstatnioWyszukiwanych
        height: 179
        anchors.left: parent.horizontalCenter
        anchors.right: parent.horizontalCenter
        anchors.leftMargin: -74
        anchors.rightMargin: -74
        delegate: Item {
            x: 5
            width: 80
            height: 40
            Row {
                id: row1
                spacing: 10
                Button {
                    id: button
                    y: 0
                    x: 0
                    height: 26
                    width: 135
                    text: name
                    onClicked: {
                        stack.push("Wyszukanemiasto.qml", {
                                       "nazwaMiasta": name
                                   })
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

    Text {
        id: text1
        y: 73
        color: "#1b37ff"
        text: qsTr("DRAWSKA")
        font.letterSpacing: 4
        font.pixelSize: 24
        anchors.horizontalCenterOffset: 1
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Text {
        id: text2
        y: 103
        color: "#000000"
        text: qsTr("POGODA")
        font.letterSpacing: 4
        font.pixelSize: 24
        anchors.horizontalCenterOffset: 1
        anchors.horizontalCenter: parent.horizontalCenter
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}D{i:2}D{i:3}D{i:7}D{i:8}D{i:9}
}
##^##*/

