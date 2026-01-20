import qs.configs
import qs.utils
import qs.components
import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import Qt.labs.platform
import QtQuick.Effects


Scope {
  id: root
  property real barHeight: 6
  Variants {
    model: Quickshell.screens;

    delegate: Component {
      PanelWindow {
        id:window
        required property var modelData
        screen: modelData

        anchors {
          bottom: true
          left: true
          right: true
        }

        mask: Region {
          item: bar
        }
        margins {
          top: -bar.height
        }


        color : "transparent" 
        implicitHeight: bar.height + bar.height*2

        Rectangle {
          id: bar
          width: window.width
          height: root.barHeight
          color: Config.color.primary.base
          anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
          }
        }

        property real startBarY: window.height-bar.height

        CurvedTriangle {
          id: leftTriangle
          startX: 0
          startY: window.startBarY
          radiusX: bar.height
          radiusY: bar.height*2

          fillColor: Config.color.primary.base
          strokeColor:Config.color.primary.subtle

          direction: CurvedTriangle.Direction.TopRight
        }
        CurvedTriangle {
          id: rightTriangle
          startX: bar.width
          startY: window.startBarY
          radiusX: bar.height
          radiusY: bar.height*2

          fillColor: Config.color.primary.base
          strokeColor:Config.color.primary.subtle

          direction: CurvedTriangle.Direction.TopLeft
        }
        Shape {
          preferredRendererType: Shape.CurveRenderer
          antialiasing: true
          ShapePath {
            fillColor: "transparent"
            strokeColor: Config.color.primary.subtle
            strokeWidth: 2

            PathMove { x: leftTriangle.startX + leftTriangle.radiusX; y: window.startBarY }
            PathLine {x : rightTriangle.startX - rightTriangle.radiusX; y:window.startBarY }
          }
        }

      }
    }
  }
}

