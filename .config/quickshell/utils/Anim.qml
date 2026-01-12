pragma Singleton

import Quickshell
import QtQuick

Singleton {
    property QtObject curves: QtObject {
        property var emphasized: [0.05, 0, 2/15, 0.06, 1/6, 0.4, 5/24, 0.82, 0.25, 1, 1, 1]
        property var emphasizedAccel: [0.3, 0, 0.8, 0.15, 1, 1]
        property var emphasizedDecel: [0.05, 0.7, 0.1, 1, 1, 1]
        property var standard: [0.2, 0, 0, 1, 1, 1]
        property var standardAccel: [0.3, 0, 1, 1, 1, 1]
        property var standardDecel: [0, 0, 0, 1, 1, 1]
        property var expressiveFastSpatial: [0.42, 1.67, 0.21, 0.9, 1, 1]
        property var expressiveDefaultSpatial: [0.38, 1.21, 0.22, 1, 1, 1]
        property var expressiveEffects: [0.34, 0.8, 0.34, 1, 1, 1]
        property var expressiveLate: [0.85, 0, 0.95, 0.15, 1, 1]

    }

    property QtObject durations: QtObject {
        property real scale: 1
        property int small: 200 * scale
        property int normal: 400 * scale
        property int large: 600 * scale
        property int extraLarge: 1000 * scale
        property int expressiveFastSpatial: 350 * scale
        property int expressiveDefaultSpatial: 500 * scale
        property int expressiveEffects: 200 * scale
    }

}
