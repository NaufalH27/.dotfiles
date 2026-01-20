import qs.services
import qs.configs
import qs.utils
import Quickshell
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts
import Qt.labs.platform
import QtQuick.Controls
import QtQuick.Effects

Rectangle {
  id: media
  width: 260
  radius: width/2
  color: "transparent"

  readonly property bool isActive:
  !!(Players.active?.trackTitle || Players.active?.trackArtist)

  RowLayout {
    anchors.fill: parent
    anchors.leftMargin:5
    anchors.rightMargin:12
    spacing: 6

    Rectangle {
      layer.enabled: true
      layer.smooth: true
      Layout.fillHeight: true
      color: "transparent"
      implicitWidth: height
      Rectangle {
        id: coverWrapper
        anchors.fill: parent
        anchors.topMargin:1
        anchors.bottomMargin:1
        anchors.centerIn: parent
        radius: width / 2
        color: "transparent"
        Rectangle {
          height: parent.height
          implicitWidth: height
          anchors.centerIn: parent
          radius: width / 2
          color: "transparent"
          Image {
            layer.enabled: true
            layer.smooth: true
            id: cover
            source: media.isActive ? Players.active?.trackArtUrl
            : Qt.resolvedUrl(StandardPaths.writableLocation(StandardPaths.HomeLocation)
            + "/.config/quickshell/assets/vinyl.png")
            anchors.centerIn: parent
            anchors.fill: parent
            visible: false
            asynchronous: true
            fillMode: Image.PreserveAspectCrop
            smooth: true
            mipmap: true
            sourceSize.width: width * Screen.devicePixelRatio
            sourceSize.height: height * Screen.devicePixelRatio
          }
          Item {
            id: coverMask
            width: height
            height: cover.height
            layer.enabled: true
            layer.smooth: true

            Rectangle {
              anchors.fill: parent
              radius: width / 2
            }
          }
          rotation: 0
          transformOrigin: Item.Center

          NumberAnimation on rotation {
            from: 0
            to: 360
            duration: 40000
            loops: Animation.Infinite
            running: Players.active?.isPlaying ?? false
          }

          MultiEffect {
            antialiasing: true
            source: cover
            anchors.fill: cover
            maskEnabled: true
            maskSource: coverMask
            maskThresholdMin: 0.5
            maskSpreadAtMin: 1
          }
        }
      }
    }

    ColumnLayout {
      spacing: 0

      Text {
        Layout.fillWidth: true
        text: isActive ? Players.active?.trackTitle : "Nothing To See Here~"
        font.pointSize:7
        font.weight: Font.DemiBold
        font.family: Fonts.sans
        color: Config.color.primary.text
        elide: Text.ElideRight
      }

      Text {
        visible: isActive && Players.active?.trackArtist !== ""
        Layout.fillWidth: true
        text: Players.active?.trackArtist ?? ""
        font.pointSize: 5
        font.family: Fonts.sans
        color: Config.color.primary.text
        elide: Text.ElideRight
        font.weight: Font.Medium
      }
    }

    RowLayout {
      Layout.fillWidth: true
      spacing: 6

      Text {
        text: "󰒮"
        font.pointSize: 12
        color: Players.active?.canGoPrevious ?
        Config.color.primary.subtle : Config.color.primary.muted

        MouseArea {
          anchors.fill: parent
          cursorShape: Players.active?.canGoPrevious
          ? Qt.PointingHandCursor
          : Qt.ArrowCursor
          enabled: Players.active?.canGoPrevious ?? false
          onClicked: Players.active?.previous()
        }
      }

      Text {
        text: Players.active?.isPlaying ? "󰏤" : "󰐊"   
        font.pointSize: 12
        color: Players.active?.canTogglePlaying ?
        Config.color.primary.subtle : Config.color.primary.muted

        MouseArea {
          anchors.fill: parent
          cursorShape: Players.active?.canTogglePlaying
          ? Qt.PointingHandCursor
          : Qt.ArrowCursor
          enabled:Players.active?.canTogglePlaying ?? false
          onClicked: Players.active?.togglePlaying()
        }
      }

      Text {
        text: "󰒭"
        font.pointSize: 12
        color: Players.active?.canGoNext ?
        Config.color.primary.subtle : Config.color.primary.muted

        MouseArea {
          anchors.fill: parent
          cursorShape: Players.active?.canGoNext
          ? Qt.PointingHandCursor
          : Qt.ArrowCursor
          enabled:Players.active?.canGoNext ?? false
          onClicked: Players.active?.next()
        }
      }
    }
  }
}
