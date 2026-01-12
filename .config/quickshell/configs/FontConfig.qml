
import Quickshell.Io
import QtQuick


JsonObject {
    property FontFamily family: FontFamily {}
    property FontSize size: FontSize {}

    component FontFamily: JsonObject {
        property string sans: "SF Pro Text"
        property string mono: "Maple Mono NL NF CN"
    }


    component FontSize: JsonObject {
        property real scale: 1
        property int small: 11 * scale
        property int smaller: 12 * scale
        property int normal: 13 * scale
        property int larger: 15 * scale
        property int large: 18 * scale
        property int extraLarge: 28 * scale
    }
}
