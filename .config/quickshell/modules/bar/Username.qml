import qs.utils
import qs.configs
import QtQuick
import Quickshell.Io

Rectangle {
  id: root
  color: "transparent"
  width: text.width
  property string username: "     "

  Process {
    running: true
    command: ["whoami"]
    stdout: StdioCollector {
      onStreamFinished: root.username = this.text
    }
  }

  Row{
    id: text
    height: parent.height
    spacing: 8
    Text {
      anchors.verticalCenter: parent.verticalCenter
      text:"<"
      font.family: Fonts.subtitle
      font.pointSize: 14
      color: Config.color.primary.text
      font.weight: 900
    }
    Text {
      anchors.verticalCenter: parent.verticalCenter
      text: root.username
      font.family: Fonts.subtitle
      font.pointSize: 14
      color: Config.color.primary.text
      font.weight: 900
    }
    Text {
      anchors.verticalCenter: parent.verticalCenter
      text:">"
      font.family: Fonts.subtitle
      font.pointSize: 14
      color: Config.color.primary.text
      font.weight: 900
    }
  }
  MouseArea {
    height: text.height
    width: text.width
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked : {
    }
  }

}
