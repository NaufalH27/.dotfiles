import qs.configs
import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import Qt.labs.platform
import QtQuick.Effects

Rectangle {
  id: root
  implicitWidth: image.width
  color:"transparent"
  Rectangle {
    id: image
    height: parent.height
    width: cover.width
    anchors.centerIn: parent
    radius: width / 2
    color:"transparent"
    Image {
      id: cover
      source: StandardPaths.writableLocation(StandardPaths.HomeLocation)
        + "/.config/quickshell/assets/mutsu_saki.jpg"
      anchors.centerIn: parent
      height: parent.height
      width: parent.height
      visible: false
      asynchronous: true
      fillMode: Image.PreserveAspectCrop
    }
    Item {
      id: coverMask
      width: cover.width
      height: cover.height
      layer.enabled: true
      visible: false

      Rectangle {
        height: cover.height
        width: cover.width
        radius: width / 2
        color: "black"
      }
    }

    MultiEffect {
      source: cover
      anchors.fill: cover
      maskEnabled: true
      maskSource: coverMask
      maskThresholdMin: 0.5
      maskSpreadAtMin: 1.0
    }
  }
  Rectangle {
    width: parent.width
    height: parent.height
    radius: width / 2
    color: "transparent"
    border.color: Config.palette.primary.subtle
    border.width: 1
  }
  MouseArea {
    height: root.height
    width: root.width
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked : {
    }
  }
}

