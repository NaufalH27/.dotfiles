import qs.utils
import qs.configs
import qs.services
import QtQuick
import Quickshell
import QtQuick.Layouts

Rectangle {
  id:root
  color: Config.palette.primary.overlay
  implicitWidth: row.implicitWidth
  radius: width/2
  Behavior on implicitWidth {
    NumberAnimation {
      duration: Anim.durations.expressiveDefaultSpatial
      easing.type: Easing.BezierSpline
      easing.bezierCurve: Anim.curves.emphasizedDecel
    }
  }
  Row {
    anchors {
      top: parent.top
      bottom: parent.bottom
      topMargin: 2 
      bottomMargin: 1
    }
    id: row
    height: root.height
    width: list.implicitWidth
    property int padding: 10

    Item {
      width: row.padding
      height: row.height
    }

    ListView {
      id: list
      model: Hypr.workspaceModel
      height: row.height
      width: contentWidth
      orientation: ListView.Horizontal
      currentIndex: Hypr.activeWsId
      interactive: false
      anchors.verticalCenter: parent.verticalCenter


      delegate: Rectangle {
        property int innerSpacing: 10
        id: pill
        color: "transparent"
        required property var model

        property int wsId : model.wsId
        property bool isSpecialWs : wsId == 0
        property bool isShown: model.exists || wsId <= Hypr.maxWsId || isSpecialWs
        property bool isActive: model.exists
        property bool isFocused: Hypr.activeWsId === wsId || Hypr.isSpecialActive && isSpecialWs
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height
        visible: isShown
        scale: isShown ? 1 : 0
        opacity: isShown ? 1.0 : 0
        implicitWidth: isShown ? parent.height + innerSpacing: 0

        Behavior on scale {
          NumberAnimation {
            duration: Anim.durations.large
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Anim.curves.emphasized
          }
        }

        Behavior on opacity {
          NumberAnimation {
            duration: Anim.durations.extraLarge
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Anim.curves.emphasized
          }
        }
        Rectangle {
          MouseArea {
            height: pill.height
            width: pill.width
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onClicked: {
              if (pill.wsId === 0) {
                Hypr.dispatch("togglespecialworkspace")
              } else {
                Hypr.dispatch(`workspace ${pill.wsId}`)
              }
            }
          }
          height: parent.height
          anchors.centerIn: parent
          width:height
          radius: width / 2
          color: pill.isSpecialWs && pill.isFocused ? Config.palette.primary.gold : "transparent"
          Behavior on color {
            ColorAnimation {
              duration: Anim.durations.normal
              easing.type: Easing.BezierSpline
              easing.bezierCurve: Anim.curves.emphasized
            }
          }
        }


        Text {
          Behavior on color {
            ColorAnimation {
              duration: Anim.durations.large
              easing.type: Easing.BezierSpline
              easing.bezierCurve: Anim.curves.standard
            }
          }

          function textColor() {
            if (pill.isFocused)
            return Config.palette.primary.highlightLow

            if (pill.isActive) {
              return pill.isSpecialWs
              ? Config.palette.primary.gold
              : Config.palette.primary.text
            }
            if (pill.isSpecialWs) {
              return Config.palette.primary.rose
            }
            return Config.palette.primary.muted
          }

          function textDisplay() {
            if (pill.isActive && pill.model.appRepIcon != "") {
              return pill.model.appRepIcon
            } else {
              return pill.isSpecialWs ? "殊" : Icon.toCnNumber(pill.wsId)
            }
          }

          text: textDisplay()
          anchors.centerIn: parent
          color: textColor()
          font.pointSize: pill.model.appRepIcon === "" ? 12 : 13
          font.family: Fonts.chinesejp
          font.weight: Font.ExtraBold
        }
      }
      Rectangle {
        id: focusIndicator
        parent: list.contentItem   
        z: -1
        width: height
        height: list.height
        anchors.verticalCenter: parent.verticalCenter
        radius: width / 2
        color: {
          if (!list.currentItem) return "transparent"
          else Config.palette.primary.text
        }

        x: list.currentItem ? list.currentItem.x + (list.currentItem.width - focusIndicator.width)/2: 0

        Behavior on x {
          NumberAnimation {
            duration: Anim.durations.expressiveDefaultSpatial
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Anim.curves.emphasized
          }
        }
      }
    }

    Item {
      width: row.padding
      height: row.height
    }
  }

}

