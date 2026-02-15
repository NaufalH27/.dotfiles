import qs.utils
import qs.configs
import qs.services
import QtQuick
import Quickshell
import QtQuick.Layouts

Rectangle {
  id:root
  color: "transparent"
  implicitWidth: row.implicitWidth
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
      currentIndex: Hypr.activeWsId - 1
      interactive: false
      anchors.verticalCenter: parent.verticalCenter


      delegate: Rectangle {
        property int innerSpacing: 12
        id: pill
        color: "transparent"
        required property var model

        property int wsId : model.wsId
        property bool isShown: model.exists || wsId <= Hypr.maxWsId
        property bool isActive: model.exists
        property bool isFocused: Hypr.activeWsId === wsId
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height
        visible: isShown
        scale: isShown ? 1 : 0
        opacity: isShown ? 1.0 : 0
        implicitWidth: isShown ? 24 + innerSpacing: 0

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
        MouseArea {
          height: pill.height
          width: pill.width
          hoverEnabled: true
          cursorShape: Qt.PointingHandCursor

          onClicked: {
            Hypr.dispatch(`workspace ${pill.wsId}`)
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
            return Config.color.primary.base

            if (pill.isActive) {
              return Config.color.primary.contrast
            }
            return Config.color.primary.muted
          }

          function textDisplay() {
          }

          text: pill.wsId
          anchors.centerIn: parent
          color: textColor()
          font.pointSize: 10
          font.family: Fonts.chinesejp
          font.weight: Font.ExtraBold
        }
      }
      Rectangle {
        id: focusIndicator
        parent: list.contentItem   
        z: -1
        width: list.currentItem ? list.currentItem.width : 0
        height: list.height
        anchors.verticalCenter: parent.verticalCenter
        color: {
          if (!list.currentItem) return "transparent"
          else Config.color.primary.contrast
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

