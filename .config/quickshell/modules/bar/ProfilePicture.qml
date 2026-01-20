import qs.components
import qs.configs
import QtQuick
import Qt.labs.platform
import QtQuick.Effects

Rectangle {
  id: root
  width: cover.width
  color:"transparent"
  Rectangle {
    id: image
    width: cover.width
    height: parent.height
    anchors.centerIn: parent
    color:"transparent"
    Image {
      id: cover
      source: StandardPaths.writableLocation(StandardPaths.HomeLocation)
        + "/.config/quickshell/assets/mutsu.jpg"
      anchors.centerIn: parent
      height: parent.height
      width: parent.height
      fillMode: Image.PreserveAspectCrop
      visible: false
      smooth: true
      mipmap: true
      asynchronous: true
      sourceSize.width: width * Screen.devicePixelRatio
      sourceSize.height: height * Screen.devicePixelRatio

    }
    Diamond {
      id: coverMask
      width: cover.width
      height: cover.height
      layer.enabled: true
      fillColor: "transparent"

    }
    Diamond {
      id: coverShadow
      width: cover.width
      height: cover.height

      fillColor: "transparent"
      strokeColor: Config.color.primary.purple
      strokeWidth: 1
    }


    MultiEffect { 
      anchors.fill: cover
      source: cover
      maskEnabled: true 
      maskSource: coverMask
      maskThresholdMin: 0.5 
      maskSpreadAtMin: 1.0 
    }
    MultiEffect {
      anchors.fill: coverShadow
      source: coverShadow
      shadowEnabled: true

      shadowVerticalOffset: 2
      shadowHorizontalOffset: 0
      shadowBlur: 0.4
      shadowOpacity: 1
      shadowColor: Config.color.primary.subtle
      z: coverMask.z-1
    }
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

