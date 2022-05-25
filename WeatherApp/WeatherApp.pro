QT += quick

SOURCES += \
        main.cpp

resources.files = main.qml  Wyszukanemiasto.qml Menu.qml sun.png snow.png rain.png part-sun.png burza-deszcz.png
resources.prefix = /$${TARGET}
RESOURCES += resources

TRANSLATIONS += \
    WeatherApp_pl_PL.ts
CONFIG += lrelease
CONFIG += embed_translations

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    Menu.qml \
    Wyszukanemiasto.qml \
    burza-deszcz.png \
    part-sun.png \
    rain.png \
    snow.png \
    sun.png
