import QtQuick
import QtQuick.Shapes

Shape {
    id: root

    property real startX: 0
    property real startY: 0

    property real radiusX: 10
    property real radiusY: 10

    property color fillColor: "lightgray"
    property color strokeColor: "black"
    property real strokeWidth: 1.5

    preferredRendererType: Shape.CurveRenderer
    antialiasing: true

    enum Direction {
        TopRight,
        TopLeft,
        BottomRight,
        BottomLeft
    }

    property int direction: CurvedTriangle.Direction.TopRight

    readonly property int dirX:
        (direction === CurvedTriangle.Direction.TopRight ||
         direction === CurvedTriangle.Direction.BottomRight) ? 1 : -1

    readonly property int dirY:
        (direction === CurvedTriangle.Direction.TopRight ||
         direction === CurvedTriangle.Direction.TopLeft) ? -1 : 1

    readonly property int arcDirection:
    (direction === CurvedTriangle.Direction.TopRight ||
     direction === CurvedTriangle.Direction.BottomLeft)
        ? PathArc.Counterclockwise
        : PathArc.Clockwise

    ShapePath {
        fillColor: root.fillColor
        strokeColor: "transparent"

        PathMove { x: root.startX; y: root.startY + root.dirY * root.radiusY }

        PathArc {
            x: root.startX + root.dirX * root.radiusX
            y: root.startY
            radiusX: root.radiusX
            radiusY: root.radiusY 
            direction: root.arcDirection
        }

        PathLine { x: root.startX; y: root.startY }
    }

    ShapePath {
        fillColor: "transparent"
        strokeColor: root.strokeColor
        strokeWidth: root.strokeWidth

        PathMove { x: root.startX; y: root.startY + root.dirY * root.radiusY }

        PathArc {
            x: root.startX + root.dirX * root.radiusX
            y: root.startY
            radiusX: root.radiusX
            radiusY: root.radiusY
            direction: root.arcDirection
        }
    }
}
