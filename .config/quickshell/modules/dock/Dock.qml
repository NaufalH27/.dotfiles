import qs.configs
import qs.utils
import qs.components
import qs.services
import Quickshell
import QtQuick
import QtQuick.Effects
import QtQuick.Shapes
import Quickshell.Hyprland
import Quickshell.Wayland


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
        WlrLayershell.layer: WlrLayer.Overlay
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
          height: window.isOpen ? dock.height*2 + 20 : dock.height + 10
          anchors.bottom: parent.bottom
          anchors.horizontalCenter: parent.horizontalCenter
          CornerRectangle {
            id: dock
            fillColor: Config.color.primary.base

            width: dock2.width + 12
            height: dock2.height + 8
            topRightX: height/3
            topRightY: height/1.5
            bottomRightY: height - topRightY
            bottomRightX: bottomRightY/2
            topLeftX: height/3
            topLeftY: height/1.5
            bottomLeftY: height - topLeftY
            bottomLeftX: bottomLeftY/2
            anchors.bottom: dockMask.top
            anchors.bottomMargin: window.isOpen ? 0 : -height - 20
            anchors.horizontalCenter: parent.horizontalCenter
            CornerRectangle {
              id: dock2
              strokeColor: Config.color.primary.highlightHigh
              strokeWidth: 0.7
              fillColor: searchMouseArea.containsMouse ? Config.color.primary.highlightMedium : Config.color.primary.highlightLow
              width: appList.width + 64
              height: appList.implicitHeight
              anchors.centerIn: parent
              topRightX: height/3
              topRightY: height/1.5
              bottomRightY: height - topRightY
              bottomRightX: bottomRightY/2
              topLeftX: height/3
              topLeftY: height/1.5
              bottomLeftY: height - topLeftY
              bottomLeftX: bottomLeftY/2

              Behavior on fillColor {
                ColorAnimation {
                  duration: Anim.durations.small
                  easing.type: Easing.BezierSpline
                  easing.bezierCurve: Anim.curves.standard
                }
              }

              CornerRectangle {
                id:shadow
                width: appList.width + 4
                height: appList.height - 6
                anchors.left: parent.left
                anchors.bottom: appList.bottom
                fillColor: Config.color.primary.highlightHigh
                topRightX: height/3
                topRightY: height/1.5
                bottomRightY: height - topRightY
                bottomRightX: bottomRightY/2
                topLeftX: height/3
                topLeftY: height/1.5
                bottomLeftY: height - topLeftY
                bottomLeftX: bottomLeftY/2
                layer.enabled: true
              }

              CornerRectangle {
                id:appList
                width: appLists.width + 36
                height: appLists.height
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                fillColor: Config.color.primary.highlightLow
                topRightX: height/3
                topRightY: height/1.5
                bottomRightY: height - topRightY
                bottomRightX: bottomRightY/2
                topLeftX: height/3
                topLeftY: height/1.5
                bottomLeftY: height - topLeftY
                bottomLeftX: bottomLeftY/2
                strokeColor: Config.color.primary.highlightHigh
                strokeWidth: 0.6
                layer.enabled: true

                AppList {
                  id: appLists
                  anchors.horizontalCenter: parent.horizontalCenter
                  anchors.centerIn: appList
                  color: "transparent"
                }

              }
              Rectangle {
                anchors.right: parent.right
                anchors.left: appList.right
                anchors.bottom: parent.bottom
                anchors.top: parent.top
                color: "transparent"
                Text {
                  text: ""
                  font.pointSize: 24
                  anchors.centerIn: parent
                  color: Config.color.primary.text
                  rotation: 82
                  leftPadding: 2
                  topPadding: 8
                }
                MouseArea {
                  id: searchMouseArea
                  anchors.fill: parent

                  hoverEnabled: true
                  cursorShape: Qt.PointingHandCursor
                }

              }


            }
            Behavior on anchors.bottomMargin {
              NumberAnimation {
                duration: Anim.durations.normal
                easing.type: Easing.BezierSpline
                easing.bezierCurve: Anim.curves.standard
              }
            }
          }
          MultiEffect {
            anchors.fill: dock
            source: dock
            shadowEnabled: true

            shadowBlur: 0.8
            shadowOpacity: 0.4
            shadowColor: "#1f1f1f"
            z: dock.z-1
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

        // HyprlandFocusGrab {
        //   id: dockGrab
        //   windows: [ window ]
        //   active: hover.hovered
        // }

      }

    }
  }
}
