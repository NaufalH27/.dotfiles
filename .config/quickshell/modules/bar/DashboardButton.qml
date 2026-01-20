import qs.configs
import QtQuick

Rectangle {
  id:root
  width:text.implicitWidth
  color:"transparent"
  Text {
    id:text
    anchors.centerIn: parent
    text:"󰕮"
    font.pointSize: 20
    color: Config.color.primary.text
  }
}