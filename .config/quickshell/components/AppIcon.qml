import QtQuick
import QtQuick.VectorImage

Item {
  id: root
  width: 48
  height: 48
  required property string iconPath
  readonly property string iconExt: getImageExtension(iconPath)
  function getImageExtension(path) {
    if (!path || path === "null") return null
    const dot = path.lastIndexOf(".")
    if (dot === -1) return null
    return path.substring(dot + 1).toLowerCase()
  }

  VectorImage {
    anchors.centerIn: parent
    anchors.fill: parent
    source: root.iconExt !== "svg" ? "" : root.iconPath
    visible: root.iconExt === "svg"
    preferredRendererType: VectorImage.CurveRenderer
  }

  Image {
    anchors.centerIn: parent
    anchors.fill: parent
    source: root.iconPath ?? ""
    fillMode: Image.PreserveAspectFit
    smooth: true
    mipmap: true
    asynchronous: true
    sourceSize.width: width * Screen.devicePixelRatio
    sourceSize.height: height * Screen.devicePixelRatio
  }
}
