import qs.configs
import qs.components
import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import Qt.labs.platform
import QtQuick.Effects


Scope {
  Variants {
    model: Quickshell.screens;

    delegate: Component {
      PanelWindow {
        id:window
        required property var modelData
        screen: modelData

        anchors {
          top: true
          left: true
          right: true
        }
        mask: Region {
          item: bar
        }

        margins {
          bottom: -bar.height/2
        }

        color : "transparent"
        implicitHeight: bar.height + bar.height/2

        Rectangle {
          id: bar
          width: window.width
          height: 37
          color: Config.palette.primary.base

          GridLayout {
            rows:3
            anchors.fill: parent
            anchors.topMargin: 5
            anchors.bottomMargin: 5
            anchors.leftMargin: 14
            anchors.rightMargin:14
            uniformCellWidths: true

            RowLayout {
              Layout.fillHeight: true
              spacing: 12
              Layout.alignment: Qt.AlignLeft

              ProfilePicture {
                Layout.fillHeight: true
              }
              Media{
                Layout.fillHeight: true
              }
              ScreenIndicator{
                Layout.fillHeight: true
              }
            }

            RowLayout {
              Layout.alignment: Qt.AlignHCenter
              Layout.fillHeight: true
              Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
              }
              Workspace {
                Layout.fillHeight: true
              }
              Item {
                Layout.fillWidth: true
              }
            }

            RowLayout {
              spacing: 20
              Layout.alignment: Qt.AlignRight
              Layout.fillHeight: true
              SystemInfo {
                Layout.fillHeight: true
              }
              SettingButton {
                Layout.fillHeight: true
              }
              ClockWidget{
                Layout.fillHeight: true
                Layout.preferredWidth: implicitWidth
              }

            }
          }
        }

        Shape {
          preferredRendererType: Shape.CurveRenderer
          antialiasing: true
          ShapePath {
            fillColor: "transparent"
            strokeColor: Config.palette.primary.subtle
            strokeWidth: 2

            PathMove { x: bar.height/2; y: bar.height }
            PathLine {x : bar.width - bar.height/2; y:bar.height }
          }
        }

        CurvedTriangle {
          startX: bar.width
          startY: bar.height
          radiusX: bar.height/2
          radiusY: bar.height/3
          strokeWidth: 2

          fillColor: Config.palette.primary.base
          strokeColor:Config.palette.primary.subtle

          direction: CurvedTriangle.Direction.BottomLeft
        }
        CurvedTriangle {
          startX: 0
          startY: bar.height
          radiusX: bar.height/2
          radiusY: bar.height/3
          strokeWidth: 2

          fillColor: Config.palette.primary.base
          strokeColor:Config.palette.primary.subtle

          direction: CurvedTriangle.Direction.BottomRight
        }
      }
    }
  }
}
