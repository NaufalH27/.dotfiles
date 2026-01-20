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
    font.pointSize: 19
    color: Config.color.primary.text
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
