import qs.configs
import Quickshell
import QtQuick
import QtQuick.Layouts
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

        Rectangle {
          id: bar
          height: 32
          width: parent.width
        }

        color : "transparent"
        implicitHeight: bar.height + bar.height/2

        Rectangle {
          clip:true
          width: bar.width
          height: bar.height
          color: "transparent"
          Image {
            id: decor
            anchors.top : parent.top
            anchors.right : parent.right
            source: Qt.resolvedUrl(
              StandardPaths.writableLocation(StandardPaths.HomeLocation)
              + "/.config/quickshell/assets/top_bar_decor.png"
            )
            opacity: 0.7
            smooth: true
            asynchronous: true
          }
        }
        Rectangle {
          clip:true
          width: bar.width
          height: bar.height
          color: "transparent"
          Image {
            id: decor2
            anchors.top : parent.top
            anchors.left : parent.left
            source: Qt.resolvedUrl(
              StandardPaths.writableLocation(StandardPaths.HomeLocation)
              + "/.config/quickshell/assets/abstract_decor.jpg"
            )
            opacity: 0.9
            smooth: true
            asynchronous: true
          }
        }


        Row {
          width: parent.width
          height: parent.height

          RowLayout {
            height: bar.height
            width: parent.width/3
            Workspace {
              Layout.alignment: Qt.AlignLeft
              Layout.fillHeight: true
            }
            Item { Layout.fillWidth: true }

          }

          Rectangle {
            height:bar.height
            Layout.preferredHeight: bar.height
            width: parent.width/3
            color: "transparent"
            Row {
              spacing: 12
              height: parent.height
              anchors.centerIn: parent
              anchors.horizontalCenter: parent.horizontalCenter
              Item {
              }
              Username {
                height: parent.height
              }
              ProfilePicture {
                anchors.top: parent.top
                anchors.topMargin: -12
                height: window.height + 8
              }

              Item {
                width: 24
                height: parent.height
              }

              Player {
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.topMargin: 4
                anchors.bottomMargin: 4
                height: parent.height
              }
            }

          }


          Rectangle {
            height:bar.height
            width: parent.width/3
            color: "transparent"
            Row {
              height: parent.height
              anchors.top: parent.top
              anchors.bottom: parent.bottom
              anchors.right: parent.right
              anchors.rightMargin: 12
              spacing: 18
              SystemInfo {
                height: parent.height
              }
              SettingButton {
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.topMargin: 4
                anchors.bottomMargin: 4
                height: parent.height
              }
              ClockWidget{
                height: parent.height
              }
            }

          }

        }


        MultiEffect {
          anchors.fill: bar
          source: bar
          shadowEnabled: true

          shadowVerticalOffset: 2
          shadowHorizontalOffset: 0
          shadowBlur: 0.4
          shadowOpacity: 1
          shadowColor: Config.color.primary.subtle
          z: bar.z-1
        }
      }
    }
  }
}
