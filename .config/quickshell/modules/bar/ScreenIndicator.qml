import qs.configs
import qs.utils
import QtQuick
import QtQuick.Layouts

Rectangle {
  id:root
  width: column.implicitWidth
  color: Config.palette.primary.rose
  radius: width/2
  RowLayout {
    id: column
    height: parent.height
    anchors.centerIn: parent
    spacing: 6
    Rectangle {
      Layout.fillHeight: true
      width: symbol.implicitWidth
      color: "transparent"
      Text {
        id: symbol
        // text:"󰹑"
        text:""
        anchors.verticalCenter: parent.verticalCenter
        font.family: Fonts.sans
        color: Config.palette.primary.base
        font.pointSize: 10
        font.weight: 900
        leftPadding: 10
      }
    }
    Rectangle {
      Layout.fillHeight: true
      width: statuss.implicitWidth
      color: "transparent"
      Text {
        id: statuss
        // text:"Sharing Screen"
        text:"Recording"
        anchors.verticalCenter: parent.verticalCenter
        font.family: Fonts.sans
        color: Config.palette.primary.base
        font.pointSize: 9
        font.weight: Font.Normal
        rightPadding:10
      }
    }
  }

}

