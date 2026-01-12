import qs.configs
import qs.utils
import qs.components
import Quickshell
import QtQuick
import Quickshell.Hyprland

Scope {
  id: root
  property real barHeight: 7
  Variants {
    model: Quickshell.screens;

    delegate: Component {
      PanelWindow {
        id: window
        required property var modelData
        screen: modelData
        anchors {
          bottom: true
        }
        color: "transparent"
        margins {
          bottom: -50
        }

        implicitHeight: appList.implicitHeight + barMask.height
        implicitWidth: appList.width + maxRadius*5
        exclusionMode: ExclusionMode.Ignore

        mask: Region {
          item: dock
        }
        property real maxRadius: 10
        property real posY: window.height - barMask.height
        property real notchHeight: dock.height - barMask.height
        property real radiusY: window.notchHeight/2 < maxRadius ? window.notchHeight/2 : maxRadius

        Column {
          id: dock
          height: notch.height + barMask.height
          clip: true
          width: notch.width
          anchors.bottom: parent.bottom
          anchors.horizontalCenter: parent.horizontalCenter
          Rectangle{
            id: notch
            width: appList.width
            height: hover.hovered ? appListss.implicitHeight : root.barHeight + 1
            color: Config.palette.primary.base
            topLeftRadius: 12
            topRightRadius: 12
            border.color: Config.palette.primary.subtle
            border.width: 2
            Rectangle {
                height: window.radiusY
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                color: parent.color    
            }
            Column {
              anchors.horizontalCenter: parent.horizontalCenter
              id: appListss
              width: appList.width + appListTopPadding.height
              Item {
                id: appListTopPadding
                width: appList.width
                height: hover.hovered ? 0 : 5
                Behavior on height {
                  NumberAnimation {
                    duration: Anim.durations.small/3
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: Anim.curves.standardAccel
                  }
                }
              }
              AppList {
                anchors.horizontalCenter: parent.horizontalCenter
                id:appList
              }
            }
            Behavior on height {
              NumberAnimation {
                duration: Anim.durations.normal
                easing.type: Easing.BezierSpline
                easing.bezierCurve: Anim.curves.standard
              }
            }
            Behavior on width {
              NumberAnimation {
                duration: Anim.durations.normal
                easing.type: Easing.BezierSpline
                easing.bezierCurve: Anim.curves.standard
              }
            }
            Behavior on width {
              NumberAnimation {
                duration: Anim.durations.normal
                easing.type: Easing.BezierSpline
                easing.bezierCurve: Anim.curves.standard
              }
            }
          }

          Rectangle {
            id: barMask
            width: notch.implicitWidth
            implicitHeight: -1 * window.margins.bottom + root.barHeight
            color: "transparent"
            z: 1
          }

        }
        HoverHandler {
            id: hover
        }
        HyprlandFocusGrab {
          id: dockGrab
          windows: [ window ]
          active: hover.hovered
      }



        CurvedTriangle {
          id: notchLeftTriangle
          startX: window.width/2 - dock.width/2 +1
          startY: window.posY-1
          radiusX: window.maxRadius
          radiusY: window.radiusY

          fillColor: Config.palette.primary.base
          strokeColor:Config.palette.primary.subtle
          strokeWidth:2

          direction: CurvedTriangle.Direction.TopLeft
        }

        CurvedTriangle {
          id: notchRightTriangle
          startX: window.width/2 + dock.width/2 -1
          startY: window.posY-1
          radiusX: window.maxRadius
          radiusY: window.radiusY
          strokeWidth:2

          fillColor: Config.palette.primary.base
          strokeColor:Config.palette.primary.subtle

          direction: CurvedTriangle.Direction.TopRight
        }
        CurvedTriangle {
          startX: notchLeftTriangle.startX
          startY: notchLeftTriangle.startY
          radiusX: notchLeftTriangle.radiusX
          radiusY: notchLeftTriangle.radiusY
          strokeWidth:2

          fillColor: Config.palette.primary.base
          strokeColor:"transparent"

          direction: CurvedTriangle.Direction.BottomLeft
        }

        CurvedTriangle {
          startX: notchRightTriangle.startX
          startY: notchRightTriangle.startY
          radiusX: notchRightTriangle.radiusX
          radiusY: notchRightTriangle.radiusY
          strokeWidth:2

          fillColor: Config.palette.primary.base
          strokeColor:"transparent"

          direction: CurvedTriangle.Direction.BottomRight
        }
      }

    }
  }
}
