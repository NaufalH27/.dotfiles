import QtQuick
import QtQuick.Shapes

Shape {
  id: root

  property color fillColor: "transparent"
  property color strokeColor: "transparent"
  property real strokeWidth: 0

  preferredRendererType: Shape.CurveRenderer
  antialiasing: true
  property bool topLeftRounded: false
  property int topLeftX: 0
  property int topLeftY: 0
  property bool topRightRounded: false
  property int topRightX: 0
  property int topRightY: 0
  property bool bottomRightRounded: false
  property int bottomRightX: 0
  property int bottomRightY: 0
  property bool bottomLeftRounded: false
  property int bottomLeftX: 0
  property int bottomLeftY: 0
  property var fillGradient: null

  function clamp(v, min, max) {
    return Math.max(min, Math.min(max, v))
  }

  readonly property real tlX: clamp(topLeftX, 0, width)
  readonly property real tlY: clamp(topLeftY, 0, height)

  readonly property real trX: clamp(topRightX, 0, width)
  readonly property real trY: clamp(topRightY, 0, height)

  readonly property real blX: clamp(bottomLeftX, 0, width)
  readonly property real blY: clamp(bottomLeftY, 0, height)

  readonly property real brX: clamp(bottomRightX, 0, width)
  readonly property real brY: clamp(bottomRightY, 0, height)

  readonly property real tlRX: topLeftRounded ? tlX : 0
  readonly property real tlRY: topLeftRounded ? tlY : 0

  readonly property real trRX: topRightRounded ? trX : 0
  readonly property real trRY: topRightRounded ? trY : 0

  readonly property real brRX: bottomRightRounded ? brX : 0
  readonly property real brRY: bottomRightRounded ? brY : 0

  readonly property real blRX: bottomLeftRounded ? blX : 0
  readonly property real blRY: bottomLeftRounded ? blY : 0


  ShapePath {
    fillColor: root.fillColor
    strokeColor: root.strokeColor
    strokeWidth: root.strokeWidth
    fillGradient: root.fillGradient

    PathMove { x: root.tlX; y: 0 }
    PathLine { x: root.width - root.trX; y: 0 }
    PathArc {
      x: root.width
      y: root.trY
      radiusY: root.trRY
      radiusX: root.trRX
      direction: PathArc.Clockwise
    }
    PathLine { x: root.width; y: root.trY }

    PathLine { x: root.width; y: root.height - root.brY }
    PathArc {
      x: root.width - root.brX
      y: root.height
      radiusY: root.brRY
      radiusX: root.brRX
      direction: PathArc.Clockwise
    }
    PathLine { x: root.width - root.brX; y: root.height }

    PathLine { x: root.blX; y: root.height }
    PathArc {
      x: 0
      y: root.height- root.blY
      radiusY: root.blRY
      radiusX: root.blRX
      direction: PathArc.Clockwise
    }
    PathLine { x: 0; y: root.height - root.blY }

    PathLine { x: 0; y: root.tlY }
    PathArc {
      x: root.tlX
      y: 0
      radiusY: root.tlRY
      radiusX: root.tlRX
      direction: PathArc.Clockwise
    }
    PathLine { x: root.tlX; y: 0 }
  }


}

