import qs.configs
import qs.utils
import qs.services
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
          bottom: -dock.height
        }

        implicitHeight: dock.height + dockMask.height + 25
        implicitWidth: dock.width + 50
        exclusionMode: ExclusionMode.Ignore

        mask: Region {
          item: hoverArea
        }

        property bool isOpen: hover.hovered || Hypr.isActiveWsEmpty

        Item {
          id: hoverArea
          width: dock.width + 40
          height: window.isOpen ? dock.height*2 + 20 : dock.height + 4
          anchors.bottom: parent.bottom
          anchors.horizontalCenter: parent.horizontalCenter
          Rectangle{
            id: dock
            width: appList.width + 10
            height: appList.implicitHeight 
            color: Config.color.primary.base
            radius: 12
            border.color: Config.color.primary.subtle
            border.width: 2
            anchors.bottom: dockMask.top
            anchors.bottomMargin: window.isOpen ? 0 : -height - 4
            anchors.horizontalCenter: parent.horizontalCenter
            AppList {
              anchors.horizontalCenter: parent.horizontalCenter
              id:appList
            }
            Behavior on anchors.bottomMargin {
              NumberAnimation {
                duration: Anim.durations.normal
                easing.type: Easing.BezierSpline
                easing.bezierCurve: Anim.curves.standard
              }
            }
          }

          Rectangle {
            id: dockMask
            width: dock.width
            anchors.bottom: parent.bottom
            implicitHeight: dock.height + 4
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
      }

    }
  }
}
