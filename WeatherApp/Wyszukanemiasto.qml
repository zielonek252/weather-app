import QtQuick 2.0
import QtQuick.Controls 6.2

Item {
    property string nazwaMiasta
    property var szerokosc
    property var wysokosc
    Component.onCompleted: {
        pobierzKordy()
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

        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                console.log(xhr.status)
                console.log(xhr.responseText)
            }
            var arr = JSON.parse(xhr.responseText)
            szerokosc = arr[0].latitude
            wysokosc = arr[0].longitude
            console.log("wysokosc: " + wysokosc)
            pobierzDaneApiOpenWeather()
        }

        xhr.send()
    }
    function pobierzDaneApiOpenWeather() {
        var apiKeyOpenWeather = "4c963dc43487a54f30bda4b41fda893f"
        console.log("Szerokosc api oneweather: " + szerokosc)
        var url = "https://api.openweathermap.org/data/2.5/onecall?lat="
                + szerokosc + "&lon=" + wysokosc + "&appid=" + apiKeyOpenWeather

        var xhr = new XMLHttpRequest()
        xhr.open("GET", url)

        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                console.log(xhr.status)
                console.log(xhr.responseText)
            }
        }

        xhr.send()
    }
    Rectangle {
        id: background
        anchors.fill: parent
        color: "white"
    }
    Text {
        id: text1
        x: 250
        y: 186
        text: "chuj"
        font.pixelSize: 12
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}
}
##^##*/

