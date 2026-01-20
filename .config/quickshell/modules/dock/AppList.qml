import qs.services
import QtQuick
import QtQuick.VectorImage
import Quickshell.Io



Rectangle {
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
    id:col
    height: row.height + topPadding + bottomPadding
    width: row.width
    property int topPadding: 8
    property int bottomPadding: 8
    Item {
      width: col.width
      height: col.topPadding
    }
    Row {
      id: row
      height: lists.implicitHeight
      width: lists.implicitWidth + rightPadding + leftPadding
      property int rightPadding: 8
      property int leftPadding: 8
      Item {
        width: row.leftPadding
        height: row.height
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
          id: appIcon
          required property var model
          width: 48
          height: 48
          radius: 10
          color: "transparent"

          Item {
            anchors.fill: parent

            VectorImage {
              anchors.centerIn: parent
              width: 48
              height: 48
              source: appIcon.model.iconExt !== "svg" ? "" : appIcon.model.icon
              visible: appIcon.model.iconExt === "svg" && appIcon.model
              preferredRendererType: VectorImage.CurveRenderer
            }

            Image {
              anchors.centerIn: parent
              width: 48
              height: 48
              source: appIcon.model.icon
              fillMode: Image.PreserveAspectFit
              smooth: true
              mipmap: true
              visible: appIcon.model.iconExt !== null && appIcon.model.iconExt !== "svg"
            }
          }
          Process {
            id: launcher
          }


          MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onClicked: {
              if (!appIcon.model.execc || appIcon.model.execc.length === 0)
              return

              launcher.command = ["sh", "-c", `gtk-launch ${appIcon.model.desktopId}`]
              launcher.running = true
            }
          }
        }
      }
      Item {
        width: row.rightPadding
        height: row.height
      }
    }
    Item {
      width: col.width
      height: col.bottomPadding
    }

  }

}

