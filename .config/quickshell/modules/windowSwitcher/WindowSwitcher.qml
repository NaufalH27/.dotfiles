import qs.components
import qs.configs
import qs.utils
import qs.services
import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Qt.labs.platform
import Qt5Compat.GraphicalEffects

Scope {

  PanelWindow {
    id: windowSwitcher
    required property var modelData
    color: "transparent"

    exclusionMode: ExclusionMode.Ignore
    implicitHeight: main.height + 200
    implicitWidth: main.width + 100
    WlrLayershell.layer: WlrLayer.Overlay
    mask : Region {
      item: mask
    }
    Item {
      id:mask
      width:0
      height:0
    }
    WlrLayershell.keyboardFocus: WindowSwitcherService.isActive ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None

    Item {
      visible: WindowSwitcherService.isActive
      focus: true
      Keys.onPressed: function(event) {
        if (event.key === Qt.Key_Q) {
          Hypr.dispatch("submap reset")
          WindowSwitcherService.selectFocus()

          WindowSwitcherService.cycleNext()
          event.accepted = true
        }

        if (event.key === Qt.Key_Tab) {
          WindowSwitcherService.cycleNext()
          event.accepted = true
        }

        if (event.key === Qt.Key_Backtab) {
          WindowSwitcherService.cyclePrev()
          event.accepted = true
        }
      }
      Keys.onReleased: function(event) {
        if (event.key === Qt.Key_Alt) {
          Hypr.dispatch("submap reset")
          WindowSwitcherService.selectFocus()
        }
      }
      height: main.height
      width: main.width
      anchors.centerIn: parent
      CornerRectangle {
        id: main
        width: preview.width
        height: preview.height + selector.height + workspaceTitle.height/2
        anchors.centerIn: parent
        topLeftX: selector.topLeftX
        topLeftY: selector.topLeftY
        topRightX: selector.topRightX
        topRightY: selector.topRightY
        bottomLeftX: preview.bottomLeftY
        bottomLeftY: preview.bottomLeftY

        CornerRectangle {
          id: selector
          anchors.bottom: preview.top

          width: preview.width
          property int topBottomPadding: 8
          height: lists.implicitHeight + topBottomPadding*2
          fillColor: Config.color.primary.base
          strokeColor: Config.color.primary.base
          strokeWidth: 1

          topLeftRounded: true
          topLeftX: 12
          topLeftY: 12
          topRightX: height
          topRightY: height

          CornerRectangle {
            id: selectorMask
            fillColor: selector.fillColor
            height: selector.height
            width: selector.width
            layer.enabled: true

            topLeftRounded: selector.topLeftRounded
            topLeftX: selector.topLeftX
            topLeftY: selector.topLeftY
            topRightX: selector.topRightX
            topRightY: selector.topRightY
          }

          Image {
            id: decor
            source: Qt.resolvedUrl(
              StandardPaths.writableLocation(StandardPaths.HomeLocation)
              + "/.config/quickshell/assets/decor2.jpg"
            )
            height: main.height 
            width: main.width
            anchors.top: selector.top
            anchors.left: selector.left
            fillMode: Image.PreserveAspectCrop
            visible: false
            smooth: true
            mipmap: true
            asynchronous: true
            sourceSize.width: width * Screen.devicePixelRatio
            sourceSize.height: height * Screen.devicePixelRatio
            mirror: true
          }

          MultiEffect { 
            id: decorMask
            source: decor
            height: decor.height-60
            width: decor.width
            maskEnabled: true 
            maskSource: selectorMask
            maskThresholdMin: 0.5 
            maskSpreadAtMin: 1.0 
            opacity: 0.2
          }

          Item {
            clip: true
            id: workspaceTitlePlaceHolder
            width: length.width
            height: parent.height
            CornerRectangle {
              id: a
              width: workspaceTitle.width + workspaceTitle.anchors.leftMargin + 24
              fillColor: "#cdd4dc"
              height: workspaceTitle.height/2 + 8
              bottomRightX: height
              bottomRightY: height
              anchors.top: parent.top
              anchors.left: parent.left
              topLeftRounded: true
              topLeftX: 12
              topLeftY: 12
            }

            CornerRectangle {
              id: length
              width: b.width + 8
              fillColor: "#93a8b6"
              height: b.height - 4
              topRightX: height 
              topRightY: height
              anchors.left: parent.left
              anchors.bottom: parent.bottom
            }


            CornerRectangle {
              id:b
              width: a.width + 8
              fillColor: "white"
              height: parent.height - a.height
              topRightX: height 
              topRightY: height 
              anchors.left: parent.left
              anchors.bottom: parent.bottom
              layer.enabled: true

              CornerRectangle {
                id: bMask
                fillColor: b.fillColor
                anchors.left: b.left
                anchors.right: b.right
                anchors.top: b.top
                anchors.bottom: b.bottom
                layer.enabled: true

                topLeftRounded: b.topLeftRounded
                topLeftX: b.topLeftX
                topLeftY: b.topLeftY
                topRightX: b.topRightX
                topRightY: b.topRightY
              }
              Image {
                id: decor2
                source: Qt.resolvedUrl(
                  StandardPaths.writableLocation(StandardPaths.HomeLocation)
                  + "/.config/quickshell/assets/decor2.jpg"
                )
                height: b.height
                width: b.width
                anchors.top: b.top
                anchors.left: b.left
                fillMode: Image.PreserveAspectCrop
                visible: false
                smooth: true
                mipmap: true
                asynchronous: true
                sourceSize.width: width * Screen.devicePixelRatio
                sourceSize.height: height * Screen.devicePixelRatio
              }
              MultiEffect { 
                source: decor2
                anchors.fill: decor2
                maskEnabled: true 
                maskSource: bMask
                maskThresholdMin: 0.5 
                maskSpreadAtMin: 1.0 
                opacity: 0.1
              }
            }
            MultiEffect {
              anchors.fill: b
              source: b
              shadowEnabled: true
              anchors.centerIn: b

              shadowBlur: 0.4
              shadowOpacity: 0.8
              shadowColor: Config.color.primary.subtle
            }
          }
          CornerRectangle {
            id:workspaceTitleShadow
            width: workspaceTitle.width
            height: workspaceTitle.height
            anchors.centerIn: workspaceTitle
            topRightX: height/2
            topRightY: height/2
            topLeftX: height/2
            topLeftY: height/2
            bottomRightX: height/2
            bottomRightY: height/2
            bottomLeftX: height/2
            bottomLeftY: height/2
            fillColor: "white"
          }
          MultiEffect {
            anchors.fill: workspaceTitleShadow
            source: workspaceTitleShadow
            shadowEnabled: true

            shadowVerticalOffset: 3
            shadowHorizontalOffset: 0
            shadowBlur: 0.4
            shadowOpacity: 0.8
            shadowColor: Config.color.primary.subtle
          }


          Item {
            id:workspaceTitle
            width: 184
            height: lists.height

            CornerRectangle {
              height: lists.height
              topRightX: height/2
              topRightY: height/2
              topLeftX: height/2
              topLeftY: height/2
              bottomRightX: height/2
              bottomRightY: height/2
              bottomLeftX: height/2
              bottomLeftY: height/2
              anchors.fill: parent
              anchors.margins: 1
              fillColor: Config.color.primary.base
              CornerRectangle {
                id:woo
                width: parent.width/2 + parent.width/8
                fillColor: Config.color.primary.highlightHigh
                height: parent.height
                topLeftX: height
                topLeftY: height
                topRightX: height/2
                topRightY: height/2
                bottomRightX: height/2
                bottomRightY: height/2

                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom

              }
              Text {
                anchors.fill:parent
                anchors.centerIn:parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: `Workspace ${Hypr.activeWsId}`
                font.family: Fonts.sans
                color: Config.color.primary.text
                font.weight: 600
                font.pointSize: 12
              }
            }
            anchors.bottom: workspaceTitlePlaceHolder.top 
            anchors.bottomMargin: -height/2
            anchors.left: workspaceTitlePlaceHolder.left
            anchors.leftMargin: 12

            layer.enabled: true
            layer.effect: InnerShadow {
              color: Config.color.primary.base
              samples: 32
              radius: 32
              spread: 0.6
            }
          }


          RowLayout {
            id: windows
            height: lists.implicitHeight
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: workspaceTitlePlaceHolder.right
            anchors.right: arrowDecor.left

            ListView {
              id: lists
              orientation: ListView.Horizontal
              interactive: false
              spacing: 8
              model: WindowSwitcherService.visibleWindows

              implicitHeight: 52
              implicitWidth: parent.width

              delegate: Rectangle {
                id: app
                required property var model
                required property int index
                color:  model.realIndex === WindowSwitcherService.selectorIndex ? length.fillColor : "transparent"
                radius: 8
                width: 52
                height: 52
                AppIcon {
                  anchors.centerIn: parent
                  width: 48
                  height: 48
                  iconPath: getAppIcon()

                  function getAppIcon() {
                    const w = app.model.window

                    let desktopId = w.initialClass;

                    if (w.initialClass === "kitty" && typeof w.title === "string") {
                      desktopId = w.title?.trim().split(/\s+/)[0] || w.initialCLass;
                    }

                    return (
                      DesktopApp.getAppByDesktopId(desktopId)?.icon ??
                      DesktopApp.getAppByDesktopId(w.initialClass)?.icon ?? ""
                    );
                  }
                }
              }
            }
          }
          CornerRectangle {
            width: selector.width- 128
            fillColor: length.fillColor
            height: 1.5
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            topLeftY: 256
            topLeftX: 100

          }

          CornerRectangle {
            id: arrowDecor
            clip: true
            fillColor: length.fillColor
            width: 100
            height: arrowDecor.height
            anchors.right: selector.right
            anchors.top: selector.top
            anchors.bottom: selector.bottom
            topRightX: height
            topRightY: height
            opacity:0.9
          }

          Rectangle {
            id: arrowDecorTail
            width: arrowDecor.width
            color: arrowDecor.fillColor
            height: selector.height
            visible: false

            anchors.right: arrowDecor.left
            anchors.top: selector.top
            anchors.bottom: selector.bottom
          }

          CornerRectangle {
            id: arrowDecorMask
            width: arrowDecorTail.width
            clip: true
            fillColor: "white"
            visible:false
            height: arrowDecorTail.height
            anchors.left: arrowDecorTail.left
            anchors.bottom: selector.bottom
            layer.enabled: true
            topRightX: height/2
            topRightY: height/2
            bottomRightX: height/2
            bottomRightY: height/2
          }

          MultiEffect {
            antialiasing: true
            source: arrowDecorTail
            anchors.fill: arrowDecorTail
            opacity: arrowDecor.opacity

            maskEnabled: true
            maskSource: arrowDecorMask
            maskThresholdMin: 0.5
            maskSpreadAtMin: 1
            maskInverted: true
          }
        }


        CornerRectangle {
          id: preview
          anchors.bottom: parent.bottom
          width: 1024
          height: 576
          fillColor: Config.color.primary.base
          strokeColor: Config.color.primary.highlightHigh
          strokeWidth: 0
          bottomLeftX: selector.height/2
          bottomLeftY: selector.height/2
          CornerRectangle {
            id: previewMask
            fillColor: preview.fillColor
            anchors.left: preview.left
            anchors.right: preview.right
            anchors.top: preview.top
            anchors.bottom: preview.bottom
            layer.enabled: true

            bottomLeftX: preview.bottomLeftX
            bottomLeftY: preview.bottomLeftY
          }

          Image {
            id: decor3
            source: Qt.resolvedUrl(
              StandardPaths.writableLocation(StandardPaths.HomeLocation)
              + "/.config/quickshell/assets/decor2.jpg"
            )
            height: preview.height
            width: preview.width
            anchors.top: preview.top
            anchors.left: preview.left
            fillMode: Image.PreserveAspectCrop
            visible: false
            smooth: true
            mipmap: true
            asynchronous: true
            sourceSize.width: width * Screen.devicePixelRatio
            sourceSize.height: height * Screen.devicePixelRatio
            mirror: true
          }

          MultiEffect { 
            source: decor3
            anchors.fill: decor3
            maskEnabled: true 
            maskSource: previewMask
            maskThresholdMin: 0.5 
            maskSpreadAtMin: 1.0 
            opacity: 0.1
          }

          CornerRectangle {
            id: preview2
            anchors.bottom: parent.bottom
            width: parent.width - 16
            height: parent.height - 16
            fillColor: "transparent"
            strokeColor: Config.color.primary.highlightHigh
            strokeWidth: 1
            anchors.centerIn: parent
            clip: true
            bottomLeftX: selector.height/2
            bottomLeftY: selector.height/2
            CornerRectangle {
              id: preview2Mask
              fillColor: Config.color.primary.base
              anchors.left: parent.left
              anchors.right: parent.right
              anchors.top: parent.top
              anchors.bottom: parent.bottom
              anchors.leftMargin: 1
              anchors.rightMargin: 1
              anchors.topMargin: 1
              anchors.bottomMargin: 1
              layer.enabled: true

              bottomLeftX: parent.bottomLeftX
              bottomLeftY: parent.bottomLeftY
            CornerRectangle {
              id: preview2Maskbg
              fillColor: Config.color.primary.base
              anchors.left: parent.left
              anchors.right: parent.right
              anchors.top: parent.top
              anchors.bottom: parent.bottom
              layer.enabled: true

              bottomLeftX: parent.bottomLeftX
              bottomLeftY: parent.bottomLeftY
            }
            Image {
              id: decor4
              source: Qt.resolvedUrl(
                StandardPaths.writableLocation(StandardPaths.HomeLocation)
                + "/.config/quickshell/assets/decor2.jpg"
              )
              height: preview2Maskbg.height
              width: preview2Maskbg.width
              anchors.top: preview2Maskbg.top
              anchors.left: preview2Maskbg.left
              fillMode: Image.PreserveAspectCrop
              visible: false
              smooth: true
              mipmap: true
              asynchronous: true
              sourceSize.width: width * Screen.devicePixelRatio
              sourceSize.height: height * Screen.devicePixelRatio
              mirror: true
            }

            MultiEffect { 
              source: decor4
              anchors.fill: decor4
              maskEnabled: true 
              maskSource: preview2Maskbg
              maskThresholdMin: 0.5 
              maskSpreadAtMin: 1.0 
              opacity: 0.1
            }
            }
            ScreencopyView {
              id: imagePreview
              height: parent.height
              width: parent.width
              captureSource: WindowSwitcherService.allWindows()?.get(WindowSwitcherService.selectorIndex)?.qsToplevel.wayland ?? null
              visible: false
            }

            MultiEffect { 
              source: imagePreview
              anchors.fill: imagePreview
              maskEnabled: true 
              maskSource: preview2Mask
              maskThresholdMin: 0.5 
              maskSpreadAtMin: 1.0 
            }


            CornerRectangle {
              id: windowTitle
              width: parent.width/2
              height: 28
              fillColor: length.fillColor
              anchors.top: preview2Mask.top
              anchors.right: preview2Mask.right

              bottomLeftX: height
              bottomLeftY: height

              layer.enabled: true
              Text {
                anchors.fill:parent
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                text: WindowSwitcherService.selectedTitle
                font.family: Fonts.sans
                color: Config.color.primary.base
                font.weight: 600
                font.pointSize: 12
                leftPadding: 28
              }



            }

          }

        }
      }
      MultiEffect {
        anchors.fill: main
        source: main
        shadowEnabled: true

        shadowVerticalOffset: 4
        shadowHorizontalOffset: 0
        shadowBlur: 0.7
        shadowOpacity: 1
        shadowColor: Config.color.primary.subtle
      }
    }






  }
}
