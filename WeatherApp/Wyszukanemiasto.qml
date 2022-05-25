import QtQuick 2.0
import QtQuick.Controls 6.2

Item {
    id: item1
    property string nazwaMiasta
    property var szerokosc
    property var wysokosc
    Component.onCompleted: {
        pobierzKordy()
        console.log("xx")
    }

    width: 640
    height: 480
    opacity: 1
    visible: true
    anchors.fill: parent

    function pobierzKordy() {
        var name = nazwaMiasta
        var apiKeyCord = "M2pvJGe6FLkQQWGpcHSLqw==ZEd7pH6pg07iozeC"
        var url = "https://api.api-ninjas.com/v1/city?name=" + name

        var xhr = new XMLHttpRequest()
        xhr.open("GET", url)

        xhr.setRequestHeader(
                    "Accept",
                    "text/javascript, text/html, application/xml, text/xml, */*")
        xhr.setRequestHeader("Content-type",
                             "application/x-www-form-urlencoded; charset=UTF-8")
        xhr.setRequestHeader("X-Api-Key", apiKeyCord)
        var response = 1
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                var arr = JSON.parse(xhr.responseText)
                szerokosc = arr[0].latitude
                wysokosc = arr[0].longitude
                text2.text = name.toUpperCase()
                pobierzDaneApiOpenWeather()
            }
        }
        xhr.send()
    }
    function pobierzDaneApiOpenWeather() {
        var apiKeyOpenWeather = "4c963dc43487a54f30bda4b41fda893f"
        var url = "https://api.openweathermap.org/data/2.5/onecall?lat="
                + szerokosc + "&lon=" + wysokosc + "&appid=" + apiKeyOpenWeather

        var xhr = new XMLHttpRequest()
        xhr.open("GET", url)
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                var arr = JSON.parse(xhr.responseText)
                text1.text = (arr.current.temp - 273.15).toFixed(2) + " 'C"
                if (arr.current.weather[0].main === "Rain") {
                    image.source = "rain.png"
                }
                if (arr.current.weather[0].main === "Snow") {
                    image.source = "snow.png"
                }
                if (arr.current.weather[0].main === "Drizzle") {
                    image.source = "rain.png"
                }
                if (arr.current.weather[0].main === "Clear") {
                    image.source = "sun.png"
                }
                if (arr.current.weather[0].main === "Clouds") {
                    image.source = "part-sun.png"
                }
                if (arr.current.weather[0].main === "Thunderstorm") {
                    image.source = "burza-deszcz.png"
                }
                text3.text = "ODCZUWALNA: " + (arr.current.feels_like - 273.15).toFixed(
                            2) + " 'C"
                var ile = 12
                //Object.keys(arr.hourly).length
                var zrodlo = []
                for (var i = 0; i < ile; i++) {
                    var datadzis = new Date(arr.hourly[i].dt * 1000)
                    if (arr.hourly[i].weather[0].main === "Rain") {
                        zrodlo[i] = "rain.png"
                    } else if (arr.hourly[i].weather[0].main === "Snow") {
                        zrodlo[i] = "snow.png"
                    } else if (arr.hourly[i].weather[0].main === "Drizzle") {
                        zrodlo[i] = "rain.png"
                    } else if (arr.hourly[i].weather[0].main === "Clear") {
                        zrodlo[i] = "sun.png"
                    } else if (arr.hourly[i].weather[0].main === "Clouds") {
                        zrodlo[i] = "part-sun.png"
                    } else if (arr.hourly[i].weather[0].main === "Thunderstorm") {
                        zrodlo[i] = "burza-deszcz.png"
                    }
                    list.append({
                                    "godzinaPogodyGodzinowej": datadzis.getHours(
                                                                   ),
                                    "zrodlo": zrodlo[i],
                                    "temperaturaPogodyGodzinowej": (arr.hourly[i].temp
                                                                    - 273.15).toFixed(
                                                                       0) + "'C"
                                })
                }
                var zrodlo2 = []
                for (i = 0; i < 7; i++) {
                    datadzis = new Date(arr.daily[i].dt * 1000)
                    if (arr.daily[i].weather[0].main === "Rain") {
                        zrodlo2[i] = "rain.png"
                    } else if (arr.daily[i].weather[0].main === "Snow") {
                        zrodlo2[i] = "snow.png"
                    } else if (arr.daily[i].weather[0].main === "Drizzle") {
                        zrodlo2[i] = "rain.png"
                    } else if (arr.daily[i].weather[0].main === "Clear") {
                        zrodlo2[i] = "sun.png"
                    } else if (arr.daily[i].weather[0].main === "Clouds") {
                        zrodlo2[i] = "part-sun.png"
                    } else if (arr.daily[i].weather[0].main === "Thunderstorm") {
                        zrodlo2[i] = "burza-deszcz.png"
                    }
                    lista.append({
                                     "tempMax": (arr.daily[i].temp.max - 273.15).toFixed(
                                                    0) + " 'C",
                                     "tempMin": (arr.daily[i].temp.min - 273.15).toFixed(
                                                    0) + " 'C",
                                     "zrodlo2": zrodlo2[i],
                                     "dataa": datadzis.getDate().toString(
                                                  ) + "." + (datadzis.getMonth(
                                                                 ) + 1).toString()
                                 })
                }
            }
        }

        xhr.send()
    }
    Rectangle {
        id: background
        anchors.fill: parent
        anchors.bottomMargin: 0
        color: "white"

        Text {
            id: text2
            y: 24
            height: 22
            text: qsTr("Text")
            anchors.left: parent.left
            anchors.right: parent.right
            font.letterSpacing: 2
            font.pixelSize: 18
            horizontalAlignment: Text.AlignHCenter
            anchors.rightMargin: 0
            anchors.leftMargin: 0
        }
        ListModel {
            id: list
        }
        GridView {
            id: gridView
            x: -49
            y: 246
            width: 1469
            model: list
            height: 69
            cellHeight: 70
            flickableDirection: Flickable.HorizontalFlick
            layoutDirection: Qt.LeftToRight
            delegate: Item {
                x: 5
                height: 50
                Column {
                    Text {
                        id: text4
                        x: 84
                        y: 375
                        text: godzinaPogodyGodzinowej
                        font.letterSpacing: 2
                        font.pixelSize: 14
                    }

                    Image {
                        id: image1
                        x: 70
                        y: 398
                        width: 45
                        height: 45
                        source: zrodlo
                        fillMode: Image.PreserveAspectFit
                    }

                    Text {
                        id: text5
                        x: 73
                        y: 452
                        text: temperaturaPogodyGodzinowej
                        font.letterSpacing: 2
                        font.pixelSize: 16
                    }
                    spacing: 5
                }
            }
            cellWidth: 70
        }
        ListModel {
            id: lista
        }

        Button {
            id: button
            y: 24
            width: 58
            height: 26
            text: qsTr("Powrot")
            anchors.left: parent.left
            anchors.leftMargin: 19
            display: AbstractButton.TextOnly
            onClicked: {
                stack.push("Menu.qml")
            }
        }
    }

    Text {
        id: text1
        y: 130
        height: 72
        text: "a"
        anchors.left: parent.left
        anchors.right: parent.right
        font.pixelSize: 60
        horizontalAlignment: Text.AlignHCenter
        anchors.rightMargin: 0
        anchors.leftMargin: 0

        Image {
            id: image
            y: -64
            height: 53
            anchors.left: parent.horizontalCenter
            anchors.right: parent.horizontalCenter
            source: "qrc:/qtquickplugin/images/template_image.png"
            anchors.rightMargin: -32
            anchors.leftMargin: -31
            fillMode: Image.PreserveAspectFit
        }
    }

    Text {
        id: text3
        y: 208
        height: 21
        text: "ODCZUWALNA: "
        anchors.left: parent.left
        anchors.right: parent.right
        font.letterSpacing: 2
        font.pixelSize: 16
        horizontalAlignment: Text.AlignHCenter
        anchors.rightMargin: 0
        anchors.leftMargin: 0
    }

    ListView {
        id: listView
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.topMargin: 421
        anchors.bottomMargin: 0
        anchors.rightMargin: 0
        anchors.leftMargin: 19
        model: lista
        ScrollBar.vertical: ScrollBar {
            active: true
        }
        delegate: Item {
            x: 5
            width: 80
            height: 40
            Row {
                id: row1
                spacing: 10
                Text {
                    id: text6
                    x: 19
                    y: -42
                    text: dataa
                    font.pixelSize: 24
                }
                Image {
                    id: image2
                    x: 95
                    y: -42
                    width: 29
                    height: 29
                    source: zrodlo2
                    fillMode: Image.PreserveAspectFit
                }

                Text {
                    id: text8
                    x: 250
                    y: -42
                    color: "#990000"
                    text: tempMax
                    font.pixelSize: 24
                }

                Text {
                    id: text7
                    x: 156
                    y: -42
                    color: "#0027c3"
                    text: tempMin
                    font.pixelSize: 24
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}D{i:2}D{i:3}D{i:4}D{i:10}D{i:11}D{i:1}D{i:13}D{i:12}D{i:14}
D{i:15}
}
##^##*/

