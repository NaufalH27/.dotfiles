import qs.configs
import qs.utils
import qs.components
import qs.services
import qs.components
import Quickshell
import QtQuick
import QtQuick.Effects
import QtQuick.Shapes
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Io


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
              fillGradient: LinearGradient {
                x1: 0; y1: 0
                x2: 0; y2: 24
                GradientStop { 
                  position: 0.0;  
                  color: searchMouseArea.containsMouse ? Config.color.primary.highlightLow : Config.color.primary.base
                  Behavior on color {
                    ColorAnimation {
                      duration: Anim.durations.normal
                      easing.type: Easing.BezierSpline
                      easing.bezierCurve: Anim.curves.standard
                    }
                  }
                }
                GradientStop { 
                  position: 1.0; 
                  color: searchMouseArea.containsMouse ? Config.color.primary.highlightMedium : Config.color.primary.highlightLow
                  Behavior on color {
                    ColorAnimation {
                      duration: Anim.durations.normal
                      easing.type: Easing.BezierSpline
                      easing.bezierCurve: Anim.curves.standard
                    }
                  }
                }
              }
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
                fillGradient: LinearGradient {
                  x1: 0; y1: 0
                  x2: 0; y2: 24
                  GradientStop { position: 0.0; color: Config.color.primary.base }
                  GradientStop { position: 1.0; color: Config.color.primary.highlightLow }
                }
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

                Rectangle {
                  id: appLists
                  anchors.horizontalCenter: parent.horizontalCenter
                  anchors.centerIn: appList
                  color: "transparent"

                  implicitWidth: col.width
                  implicitHeight: col.height

                  property var hi: DesktopApp

                  ListModel {
                    id: rectModel
                    Component.onCompleted: {
                      for (let i = 0; i < 7; i++)
                      append({})
                    }
                  }

                  Column {
                    id: col
                    height: 48 + topPadding + bottomPadding
                    width: lists.width

                    property int topPadding: 4
                    property int bottomPadding: 4

                    Item {
                      width: col.width
                      height: col.topPadding
                    }

                    ListView {
                      id: lists
                      orientation: ListView.Horizontal
                      flickableDirection: Flickable.HorizontalAndVerticalFlick
                      model: DesktopApp.dock
                      spacing: 8
                      interactive: false

                      implicitHeight: contentItem.childrenRect.height
                      implicitWidth: contentWidth

                      delegate: Rectangle {
                        id: app
                        required property var model

                        width: 48
                        height: 48
                        radius: 10
                        color: "transparent"

                        AppIcon {
                          iconPath: app.model.icon
                        }

                        Process {
                          id: launcher
                          command: ["sh", "-c", `gtk-launch ${app.model.desktopId}`]
                        }

                        MouseArea {
                          id: mouse
                          anchors.fill: parent
                          hoverEnabled: true
                          cursorShape: Qt.PointingHandCursor

                          onEntered: {
                            tooltip.show(app, app.model.name)
                          }

                          onExited: {
                            tooltip.hide()
                          }

                          onPositionChanged: {
                            if (tooltip.visible)
                            tooltip.show(app, app.model.name)
                          }

                          onClicked: {
                            launcher.startDetached()
                          }
                        }
                      }
                    }

                    Item {
                      width: col.width
                      height: col.bottomPadding
                    }
                  }

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
            id: tooltip
            visible: false
            opacity: visible ? 1 : 0

            radius: 2
            color: Config.color.primary.highlightMedium
            width: text.width + 12
            height: text.height 


            Behavior on opacity {
              NumberAnimation { duration: 120 }
            }

            Text {
              id: text
              anchors.centerIn: parent
              color: Config.color.primary.text
              font.pointSize: 8
            }

            function show(target, label) {
              text.text = label
              var p = target.mapToItem(appList, 0, 0)
              x = p.x + target.width/2 - width/4
              y = p.y - height + 5

              visible = true
            }

            function hide() {
              visible = false
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
