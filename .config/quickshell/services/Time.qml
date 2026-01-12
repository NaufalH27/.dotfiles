pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property date now: new Date()

    property string year:   Qt.formatDateTime(now, "yyyy")
    property string month:  Qt.formatDateTime(now, "MM")
    property string day:    Qt.formatDateTime(now, "dd")

    property string hour24: Qt.formatDateTime(now, "HH")
    property string minute: Qt.formatDateTime(now, "mm")
    property string second: Qt.formatDateTime(now, "ss")

    property int hour24Int: now.getHours()
    property int hour12Int: {
      const h = hour24Int % 12
      return h === 0 ? 12 : h
    }
    property string hour12: hour12Int < 10
        ? "0" + hour12Int
        : hour12Int.toString()
    property string ampm:   Qt.formatDateTime(now, "AP")

    property string time24: Qt.formatDateTime(now, "HH:mm:ss")
    property string time12: Qt.formatDateTime(now, "hh:mm:ss AP")

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: now = new Date()
    }
}
