import qs.services
import qs.configs
import qs.utils
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower

Rectangle {
  id:root
  width: column.implicitWidth
  color: "transparent"
  property var aa: Audio
  property var nn: Networking
  property var bb: Battery
  property var fontSize: 11
  RowLayout {
    id: column
    height: parent.height
    anchors.centerIn: parent
    spacing: 18
    Rectangle {
      Layout.fillHeight: true
      width: mic.implicitWidth
      color: "transparent"
      Text {
        id: mic
        text:Audio.activeMic?.audio.muted ? "󰍭" : ""
        anchors.verticalCenter: parent.verticalCenter
        font.family: Fonts.sans
        color: Config.color.primary.text
        font.pointSize: root.fontSize
        MouseArea {
          height: mic.height
          width: mic.width
          hoverEnabled: true
          cursorShape: Qt.PointingHandCursor
          onClicked : {
            Audio.activeMic.audio.muted = !Audio.activeMic?.audio.muted
          }
        }
      }
    }
    Rectangle {
      width: volume.implicitWidth
      Layout.fillHeight: true
      color: "transparent"
      Text {
        id:volume
        anchors.verticalCenter: parent.verticalCenter
        text:Audio.activeSpeaker?.audio.muted ? "" : Icon.volumeIcon(Audio.activeSpeaker?.audio.volume * 100)
        font.family: Fonts.sans
        color: Config.color.primary.text
        font.pointSize: root.fontSize 
        MouseArea {
          height: volume.height
          width: volume.width
          hoverEnabled: true
          cursorShape: Qt.PointingHandCursor
          onClicked : {
            Audio.activeSpeaker.audio.muted = !Audio.activeSpeaker?.audio.muted
          }
        }
      }
    }
    Rectangle {
      width: bluetooth.implicitWidth
      Layout.fillHeight: true
      color: "transparent"
      Text {
        id:bluetooth
        anchors.verticalCenter: parent.verticalCenter
        text:"󰂯"
        font.family: Fonts.sans
        color: Config.color.primary.text
        font.pointSize: root.fontSize
      }
    }
    Rectangle {
      width: wifi.implicitWidth
      Layout.fillHeight: true
      color: "transparent"
      Text {
        visible: Networking.topNetwork === null || Networking.topNetwork !== null && Networking.topNetwork.type === "wifi" 
        id:wifi
        anchors.verticalCenter: parent.verticalCenter
        text: Networking.topNetwork === null ? "wifi_off"  : "wifi" 
        font.family: Fonts.material
        color: Config.color.primary.text
        font.pointSize: root.fontSize
      }

      Text {
        visible: Networking.topNetwork !== null && Networking.topNetwork.type === "ethernet" 
        id:ethernet
        anchors.verticalCenter: parent.verticalCenter
        text: "󰍹" 
        font.family: Fonts.sans
        color: Config.color.primary.text
        font.pointSize: root.fontSize
      }

      Text {
        visible: ethernet.visible
        anchors.left: ethernet.left
        anchors.top: ethernet.top
        text: "󰈁" 
        leftPadding: -3
        font.family: Fonts.sans
        color: Config.color.primary.text
        font.pointSize:root.fontSize
      }
    }
    Rectangle {
      Layout.fillHeight: true
      width: battery.implicitWidth
      color: "transparent"
      Text {
        id: battery
        text:Icon.batteryIcon(Battery.levelPercentage * 100)
        anchors.verticalCenter: parent.verticalCenter
        font.family: Fonts.material
        color: Battery.device.state === UPowerDeviceState.Charging ? Config.color.primary.green : Battery.levelPercentage * 100 <= 20 ? Config.color.primary.red : Config.color.primary.text
        font.pointSize: root.fontSize+4
      }
      Text {
        text:Icon.batteryIcon(0)
        anchors.centerIn: battery
        font.family: battery.font.family
        color: Config.color.primary.subtle
        font.pointSize: battery.font.pointSize
        rightPadding: battery.rightPadding
        leftPadding: battery.leftPadding
      }
      Text {
        id: batteryCharging
        visible: Battery.device.state === UPowerDeviceState.Charging
        text: "󱐋"
        anchors.centerIn: parent
        rightPadding: 2
        leftPadding: battery.leftPadding
        font.family: Fonts.sans
        color: Config.color.primary.surface
        font.pointSize: 13
      }
      Text {
        visible: batteryCharging.visible
        text: batteryCharging.text
        anchors.centerIn: batteryCharging
        rightPadding: batteryCharging.rightPadding
        leftPadding: batteryCharging.leftPadding
        font.family: batteryCharging.font.family
        color: Config.color.primary.subtle
        font.pointSize: 9
      }
    }
  }

}
