import Quickshell.Io

JsonObject {
    property bool enabled: true
    property int maxToast: 4

    property Size sizes: Size {}
    property Toast toast: Toast {}

    component Size: JsonObject {
        property int width: 430
        property int toastWidth: 430
    }

    component Toast: JsonObject {
        property bool configLoaded: true
        property bool chargingChanged: true
        property bool gameModeChanged: true
        property bool dndChanged: true
        property bool audioOutputChanged: true
        property bool audioInputChanged: true
        property bool capsLockChanged: true
        property bool numLockChanged: true
        property bool kbLayoutChanged: true
        property bool vpnChanged: true
        property bool nowPlaying: false
    }
}