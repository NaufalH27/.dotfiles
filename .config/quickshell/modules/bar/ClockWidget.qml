import qs.services
import qs.configs
import qs.utils
import QtQuick
import QtQuick.Layouts

Rectangle {
  id:root
  property int clockFormat: Config.system.clock.clockFormat
  implicitWidth: column.implicitWidth
  color: "transparent"

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor

    onClicked: {
      fadeAnim.restart()
    }
  }
  SequentialAnimation { 
    id: fadeAnim 
    NumberAnimation {
      target: column 
      property: "opacity" 
      to: 0 
      duration: 
      Anim.durations.small 
      easing.bezierCurve: Anim.curves.standardDecel 
    } 
    ScriptAction { 
      script: Config.system.clock.clockFormat = (Config.system.clock.clockFormat + 1) % 4
    } 
    NumberAnimation { 
      target: column 
      property: "opacity" 
      to: 1 
      duration: Anim.durations.small
      easing.bezierCurve: Anim.curves.standard 
    } 
  }


  Behavior on Layout.preferredWidth {
    NumberAnimation {
      duration: Anim.durations.normal
      easing.bezierCurve: Anim.curves.standard
    }
  }

  ColumnLayout {
    id:column
    anchors.right: parent.right
    height: parent.height
    spacing: -3
    
    Row {
      id: time
      Layout.fillHeight: true
      Layout.alignment: Qt.AlignRight 
      spacing: root.clockFormat === 0 ? 7 : 4
      property int fontSize: 12
      Text {
        anchors.verticalCenter: parent.verticalCenter
        visible: root.clockFormat === 0 
        opacity: 1
        text: ""
        color: Config.color.primary.text
        font.pointSize: time.fontSize
        font.family: Fonts.sans
        font.weight: 900
      }
      Text {
        anchors.verticalCenter: parent.verticalCenter
        opacity: 1
        text: root.clockFormat === 0 || root.clockFormat === 2
              ? Time.hour24 + ":" + Time.minute
              :  Time.hour12 + ":" + Time.minute


        color: Config.color.primary.text
        font.pointSize: root.clockFormat === 0 || root.clockFormat === 1 ? time.fontSize : 8
        font.family: Fonts.sans
        font.weight: 500
      }

      Text {
        anchors.verticalCenter: parent.verticalCenter
        opacity: 1
        text: root.clockFormat === 0 || root.clockFormat === 2
              ? ""
              :  Time.ampm


        color: Config.color.primary.text
        font.pointSize: root.clockFormat === 0 || root.clockFormat === 1 ? time.fontSize : 8
        font.family: Fonts.sans
        font.weight: 500
      }

    }

    Text {
      Layout.fillHeight: true
      Layout.alignment: Qt.AlignRight
      visible: root.clockFormat === 2 || root.clockFormat === 3
      opacity: 1
      text: Time.day + "/" + Time.month + "/" + Time.year
  

      color: Config.color.primary.text
      font.pointSize: 8
      font.family: Fonts.sans
      font.weight: 600
    }

  }

}
