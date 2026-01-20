import qs.configs
import QtQuick
import QtQuick.Layouts

Rectangle {
    id:root
    width: column.implicitWidth
    color: "transparent"
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onClicked: {}
    }
    ColumnLayout {
        id: column
        height: parent.height
        anchors.centerIn: parent
        spacing: -6
        Rectangle {
            width: symbol.implicitWidth
            Layout.fillHeight: true
            color: "transparent"
            Text {
                id:symbol
                anchors.verticalCenter: parent.verticalCenter
                text:"󰨙"
                transform: Scale {
                    xScale: 1.2
                    yScale: 0.95
                }
                font.family: Config.font.family.sans
                color: Config.color.primary.text
                font.pointSize: 11
            }

        }
        Rectangle {
            Layout.fillHeight: true
            width: symbol2.implicitWidth
            color: "transparent"
            Text {
                id: symbol2
                text:"󰔡"
                transform: Scale {
                    xScale: 1.3
                }

                anchors.verticalCenter: parent.verticalCenter
                font.family: Config.font.family.sans
                color: Config.color.primary.contrast
                font.pointSize: 11
            }

        }

    }

}
