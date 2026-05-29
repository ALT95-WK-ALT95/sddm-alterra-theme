import QtQuick 2.0
import SddmComponents 2.0
import QtMultimedia 5.8

Item {
    id: page
    width: 1920
    height: 1080

    property bool cargaTerminada: false

    Rectangle {
        anchors.fill: parent
        color: "black"
    }

    Image {
        id: fondoEstatico
        anchors.fill: parent
        source: "Assets/fondo_pda.png"
        fillMode: Image.PreserveAspectCrop
        visible: cargaTerminada
    }

    MediaPlayer {
        id: mediaplayer1
        source: "Assets/videos/alterra_bienvenida.mp4"
        autoPlay: true
        muted: false
        loops: 1
        onStopped: {
            cargaTerminada = true
            mediaplayer2.play()
        }
    }

    VideoOutput {
        id: video1
        fillMode: VideoOutput.PreserveAspectCrop
        anchors.fill: parent
        source: mediaplayer1
        opacity: cargaTerminada ? 0 : 1
        Behavior on opacity {
            NumberAnimation { duration: 500 }
        }
    }

    MediaPlayer {
        id: mediaplayer2
        source: "Assets/videos/alterra_espera.mp4"
        autoPlay: false
        muted: true
        loops: MediaPlayer.Infinite
    }

    VideoOutput {
        id: video2
        fillMode: VideoOutput.PreserveAspectCrop
        anchors.fill: parent
        source: mediaplayer2
        opacity: cargaTerminada ? 1 : 0
        Behavior on opacity {
            NumberAnimation { duration: 500 }
        }
    }


    Rectangle {
        id: pdaClockContainer
        anchors {
            right: parent.right
            bottom: parent.bottom
            margins: 30
        }
        width: pdaClockLayout.implicitWidth + 20
        height: pdaClockLayout.implicitHeight + 10
        color: "#1D395E"
        border.color: "#4C8DC2"
        border.width: 1
        radius: 2

        Column {
            id: pdaClockLayout
            anchors.centerIn: parent
            spacing: 0

            Text {
                id: timeText
                anchors.horizontalCenter: parent.horizontalCenter
                font { family: "Fira Mono"; pointSize: 14; bold: true }
                color: "#9CE4F2"
                text: Qt.formatTime(new Date(), "hh:mm")
            }
            Text {
                id: dateText
                anchors.horizontalCenter: parent.horizontalCenter
                font { family: "Fira Mono"; pointSize: 8 }
                color: "#6DD4E3"
                text: Qt.formatDate(new Date(), "ddd dd/MM/yyyy")
            }
        }

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: {
                timeText.text = Qt.formatTime(new Date(), "hh:mm")
                dateText.text = Qt.formatDate(new Date(), "ddd dd/MM/yyyy")
            }
        }
    }


    Row {
        id: pdaSystemButtons
        anchors {
            left: parent.left
            bottom: parent.bottom
            margins: 30
        }
        spacing: 15

        Image {
            source: "Assets/shutdown_normal.png"
            width: 24
            height: 24
            MouseArea {
                anchors.fill: parent
                onClicked: sddm.powerOff()
            }
        }
        Image {
            source: "Assets/restart_normal.png"
            width: 24
            height: 24
            MouseArea {
                anchors.fill: parent
                onClicked: sddm.reboot()
            }
        }
        Image {
            source: "Assets/session_normal.png"
            width: 24
            height: 24
            MouseArea {
                anchors.fill: parent
                onClicked: sddm.suspend()
            }
        }
    }


    Text {
        anchors {
            top: parent.top
            left: parent.left
            margins: 30
        }
        text: "16 °C - NSCD\nPressure: 1022 Mb"
        font { family: "Fira Mono"; pointSize: 10 }
        color: "#6DD4E3"
        opacity: 0.7
    }


    Image {
        id: sessionGearIcon
        anchors {
            top: parent.top
            right: parent.right
            margins: 30
        }
        source: "Assets/Selector.png"
        width: 24
        height: 24
        MouseArea {
            anchors.fill: parent
            onClicked: sessionSelect.visible = !sessionSelect.visible
        }
    }

    Rectangle {
        id: sessionSelectContainer
        anchors {
            top: sessionGearIcon.bottom
            right: parent.right
            margins: 10
        }
        width: 140
        height: sessionSelect.count * 30
        color: "#1D395E"
        border.color: "#4C8DC2"
        border.width: 1
        radius: 2
        visible: sessionSelect.visible

        ListView {
            id: sessionSelect
            anchors.fill: parent
            model: sessionModel
            currentIndex: sessionModel.lastIndex
            visible: false
            clip: true
            flickableDirection: Flickable.AutoFlickIfNeeded

            delegate: Item {
                width: 140
                height: 30
                Text {
                    text: name
                    color: "#9CE4F2"
                    font { family: "Fira Mono"; pointSize: 10 }
                    anchors.centerIn: parent
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        sessionSelect.currentIndex = index
                        sessionSelect.visible = false
                    }
                }
            }
        }
    }


    Rectangle {
        id: loginContainer
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 120
        }
        width: 650
        height: 130
        color: "#0D1F33"
        border.color: "#4C8DC2"
        border.width: 1
        radius: 3
        visible: false
        opacity: 0

        Behavior on opacity {
            NumberAnimation { duration: 800 }
        }

        Loader {
            id: loginLoader
            x: 0
            y: 0
            width: parent.width
            height: parent.height
            source: "Login.qml"
            onLoaded: {
                item.selectedSession = Qt.binding(function() {
                    return sessionSelect.currentIndex
                })
            }
        }
    }

    Timer {
        id: loginDelay
        interval: 8000
        running: true
        repeat: false
        onTriggered: {
            loginContainer.visible = true
            loginContainer.opacity = 1
        }
    }
}
