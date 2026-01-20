pragma Singleton

import Quickshell
import Quickshell.Services.UPower

Singleton {
  id: root

  readonly property var romanDigit: ({
    1: "I",
    2: "II",
    3: "III",
    4: "IV",
    5: "V",
    6: "VI",
    7: "VII",
    8: "VIII",
    9: "IX",
    10: "X"
  })



  function volumeIcon(volume) {
    if (volume === 0) return "";
    if (volume >= 1 && volume <= 40) return "";
    if (volume >= 41 && volume <= 100) return "";
    return "";
  }

  // this one use Google Material symbols
  function batteryIcon(level) {
    level = Math.max(0, Math.min(100, level));

    if (level === 0) return "battery_android_0";
    if (level <= 5) return "battery_android_frame_1";
    if (level <= 25) return "battery_android_frame_2";
    if (level <= 45) return "battery_android_frame_3";
    if (level <= 60) return "battery_android_frame_4";
    if (level <= 80) return "battery_android_frame_5";
    if (level <= 95) return "battery_android_frame_6";
    return "battery_android_frame_full";
  }

  function powerState(batteryState) {
    switch (batteryState) {
      case PowerProfile.PowerSaver:
        return ""
      case PowerProfile.Performance:
        return ""
      case PowerProfile.Balanced:
        return ""
      default:
        return ""
    }
  }

}
