import QtQuick
import QtQuick.Shapes

Shape {
    id: root

    property color fillColor: "white"
    property color strokeColor: "transparent"
    property real strokeWidth: 1.5
    height: 0
    width: 0

    preferredRendererType: Shape.CurveRenderer
    antialiasing: true

    ShapePath {
        PathMove { x: 0; y: root.height/2}
        PathLine { x: root.width/2; y: 0}
        PathLine { x: root.width; y: root.height/2}
        PathLine { x: root.width/2; y: root.height}
        PathLine { x: 0; y: root.height/2}
    }

    ShapePath {
        fillColor: "transparent"
        strokeColor: root.strokeColor
        strokeWidth: root.strokeWidth
        PathMove { x: 0; y: root.height/2}
        PathLine { x: root.width/2; y: 0}
        PathLine { x: root.width; y: root.height/2}
        PathLine { x: root.width/2; y: root.height}
        PathLine { x: 0; y: root.height/2}
    }
}
