import qs.components
import qs.services
import QtQuick
import Quickshell.Io

Rectangle {
  id: root
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

  Rectangle {
    id: tooltip
    visible: false
    opacity: visible ? 1 : 0

    radius: 6
    color: "white"
    width: 100
    height: 100


    Behavior on opacity {
      NumberAnimation { duration: 120 }
    }

    Text {
      id: text
      anchors.centerIn: parent
      color: "black"
      font.pixelSize: 12
    }

    function show(target, label) {
      text.text = label

      // var p = target.mapToItem(root, 0, 0)
      //
      // x = p.x + target.width / 2 - width / 2
      // y = p.y - height - 6

      visible = true
    }

    function hide() {
      visible = false
    }
  }
}
