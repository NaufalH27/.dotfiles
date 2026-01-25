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


  component Path: ShapePath {
    id: path

    property real height: 20
    property real width: 20

    property bool tlRounded: false
    property real tlX: 0
    property real tlY: 0

    property bool trRounded: false
    property real trX: 0
    property real trY: 0

    property bool brRounded: false
    property real brX: 0
    property real brY: 0

    property bool blRounded: false
    property real blX: 0
    property real blY: 0
    readonly property real tlRX: path.tlRounded ? path.tlX : 0
    readonly property real tlRY: path.tlRounded ? path.tlY : 0

    readonly property real trRX: path.trRounded ? path.trX : 0
    readonly property real trRY: path.trRounded ? path.trY : 0

    readonly property real brRX: path.brRounded ? path.brX : 0
    readonly property real brRY: path.brRounded ? path.brY : 0

    readonly property real blRX: path.blRounded ? path.blX : 0
    readonly property real blRY: path.blRounded ? path.blY : 0

    PathMove { x: path.tlX; y: 0 }
    PathLine { x: path.width - path.trX; y: 0 }
    PathArc {
      x: path.width
      y: path.trX
      radiusY: path.trRX
      radiusX: path.trRY
      direction: PathArc.Clockwise
    }
    PathLine { x: path.width; y: path.trY }

    PathLine { x: path.width; y: path.height - path.brY }
    PathArc {
      x: path.width - path.brX
      y: path.height
      radiusY: path.brRY
      radiusX: path.brRX
      direction: PathArc.Clockwise
    }
    PathLine { x: path.width - path.brX; y: path.height }

    PathLine { x: path.blX; y: path.height }
    PathArc {
      x: 0
      y: path.height- path.blY
      radiusY: path.blRY
      radiusX: path.blRX
      direction: PathArc.Clockwise
    }
    PathLine { x: 0; y: path.height - path.blY }

    PathLine { x: 0; y: path.tlY }
    PathArc {
      x: path.tlX
      y: 0
      radiusY: path.tlRY
      radiusX: path.tlRX
      direction: PathArc.Clockwise
    }
    PathLine { x: path.tlX; y: 0 }
  }

  Path {
    height: root.height
    width: root.width
    fillColor: root.fillColor
    strokeColor: root.strokeColor
    strokeWidth: root.strokeWidth
    tlRounded: root.topLeftRounded
    tlX: root.tlX
    tlY: root.tlY

    trRounded: root.topRightRounded
    trX: root.trX
    trY: root.trY

    brRounded: root.bottomRightRounded
    brX: root.brX
    brY: root.brY

    blRounded: root.bottomLeftRounded
    blX: root.blX
    blY: root.blY
  }

}

