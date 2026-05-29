import QtQuick 2.0

Item {
    id: loginConsole
    width: parent ? parent.width : 650
    height: parent ? parent.height : 130

    property int selectedSession: 0
    property bool hasUser: false
    property string userName: ""

    Component.onCompleted: {
        var last = sddm.lastUser || ""
        hasUser = (last !== "")
        userName = last
        if (hasUser) {
            passwordInput.focus = true
        } else {
            userInput.focus = true
        }
    }

    function login() {
        var user = hasUser ? userName : userInput.text
        if (user === "") {
            showError("No Crew Member Detected")
            return
        }
        errorMsg.visible = false
        sddm.login(user, passwordInput.text, selectedSession)
    }

    function showError(msg) {
        errorMsg.text    = msg
        errorMsg.visible = true
        errorTimer.restart()
    }

    Connections {
        target: sddm
        function onLoginFailed() {
            showError("Access Denied - Invalid Key")
            passwordInput.text  = ""
            passwordInput.focus = true
        }
    }

    Text {
        id: titleText
        x: 0
        y: 12
        width: loginConsole.width
        horizontalAlignment: Text.AlignHCenter
        text: "ALTERRA CORP — CREW VERIFICATION SYSTEM"
        color: "#4C8DC2"
        font { family: "Fira Mono"; pointSize: 9; bold: true }
    }

    Rectangle {
        x: 16
        y: titleText.y + titleText.height + 8
        width: loginConsole.width - 32
        height: 1
        color: "#4C8DC2"
        opacity: 0.4
    }

    Text {
        id: labelUser
        x: 16
        y: titleText.y + titleText.height + 20
        text: "> Crew Member:"
        color: "#6DD4E3"
        font { family: "Fira Mono"; pointSize: 10 }
    }

    Text {
        id: userDisplay
        x: labelUser.x + labelUser.width + 8
        y: labelUser.y
        text: userName !== "" ? userName : "---"
        color: "#9CE4F2"
        font { family: "Fira Mono"; pointSize: 10; bold: true }
        visible: hasUser
    }

    Text {
        x: userDisplay.x + userDisplay.width + 8
        y: labelUser.y
        text: "[✓ IDENTIFIED]"
        color: "#3CBA78"
        font { family: "Fira Mono"; pointSize: 8 }
        visible: hasUser
    }

    TextInput {
        id: userInput
        x: labelUser.x + labelUser.width + 8
        y: labelUser.y
        width: 160
        color: "#9CE4F2"
        font { family: "Fira Mono"; pointSize: 10; bold: true }
        visible: !hasUser
        KeyNavigation.tab: passwordInput
        onAccepted: passwordInput.focus = true

        Rectangle {
            x: 0
            y: parent.height
            width: parent.width
            height: 1
            color: "#4C8DC2"
        }
    }

    Text {
        id: labelPass
        x: 16
        y: labelUser.y + 30
        text: "> Access Key:"
        color: "#6DD4E3"
        font { family: "Fira Mono"; pointSize: 10 }
    }

    TextInput {
        id: passwordInput
        x: labelPass.x + labelPass.width + 8
        y: labelPass.y
        width: 180
        color: "#FFA500"
        font { family: "Fira Mono"; pointSize: 10; bold: true }
        echoMode: TextInput.Password
        onAccepted: loginConsole.login()

        cursorVisible: true
        cursorDelegate: Rectangle {
            width: 8
            height: 14
            color: "#FFA500"
            SequentialAnimation on opacity {
                loops: Animation.Infinite
                NumberAnimation { to: 0.1; duration: 500 }
                NumberAnimation { to: 0.9; duration: 500 }
            }
        }

        Rectangle {
            x: 0
            y: parent.height
            width: parent.width
            height: 1
            color: "#4C8DC2"
        }
    }

    Rectangle {
        id: enterBtn
        x: passwordInput.x + passwordInput.width + 12
        y: labelPass.y - 2
        width: enterLabel.implicitWidth + 20
        height: 22
        color: "transparent"
        border.color: "#4C8DC2"
        border.width: 1
        radius: 2

        Text {
            id: enterLabel
            text: "ENTER"
            color: "#4C8DC2"
            font { family: "Fira Mono"; pointSize: 8; bold: true }
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: enterBtn.color = "#1D395E"
            onExited:  enterBtn.color = "transparent"
            onClicked: loginConsole.login()
        }
    }

    Text {
        id: errorMsg
        x: 0
        y: labelPass.y + 30
        width: loginConsole.width
        horizontalAlignment: Text.AlignHCenter
        text: ""
        color: "#FFA500"
        font { family: "Fira Mono"; pointSize: 9 }
        visible: false
    }

    Timer {
        id: errorTimer
        interval: 3000
        onTriggered: errorMsg.visible = false
    }
}
