import qs.components
import qs.services
import QtQuick
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
      property int rightPadding: 2
      property int leftPadding: 2
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
            command : ["sh", "-c", `gtk-launch ${app.model.desktopId}`]
          }


          MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onClicked: {
              launcher.startDetached()
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

