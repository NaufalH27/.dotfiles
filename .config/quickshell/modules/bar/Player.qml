import qs.services
import qs.configs
import qs.components
import qs.utils
import Quickshell
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts
import Qt.labs.platform
import QtQuick.Controls
import QtQuick.Effects

CornerRectangle {
  id: media
  width: 140
  fillColor: "transparent"
  topRightX: height/2
  topRightY: height/2
  bottomRightX: height/2
  bottomRightY: height/2
  bottomLeftX: height/2
  bottomLeftY: height/2
  topLeftX: height/2
  topLeftY: height/2

  readonly property bool isActive:
  !!(Players.active?.trackTitle || Players.active?.trackArtist)

  Rectangle {
    id:coverWrapper
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.leftMargin: 8
    anchors.topMargin: 2
    anchors.bottomMargin: anchors.topMargin
    width: height
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
    Rectangle {
      id: coverMask
      width: height
      height: cover.height
      layer.enabled: true
      layer.smooth: true
      radius: 4
    }

    Rectangle {
      id: coverMaskShadow
      width: height
      height: cover.height
      layer.enabled: true
      layer.smooth: true
      radius: 4
    }

    MultiEffect {
      anchors.fill: coverMaskShadow
      source: coverMaskShadow
      shadowEnabled: true

      shadowVerticalOffset: 2
      shadowHorizontalOffset: 2
      shadowBlur: 0.4
      shadowOpacity: 1
      shadowColor: Config.color.primary.subtle
      z: coverMask.z-1
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


  Text {
    id: play
    anchors.left: coverWrapper.right
    anchors.verticalCenter: parent.verticalCenter
    anchors.leftMargin: 16
    text: Players.active?.isPlaying ? "󰏤" : "󰐊"   
    font.pointSize: 14
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
    id: prev
    text: ""
    font.pointSize: 14
    anchors.left: play.right
    anchors.leftMargin: 16
    anchors.verticalCenter: parent.verticalCenter
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
    anchors.left: prev.right
    anchors.leftMargin: 8
    anchors.verticalCenter: parent.verticalCenter
    text: ""
    font.pointSize: 14
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
