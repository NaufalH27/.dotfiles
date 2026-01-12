pragma Singleton

import Quickshell
import Quickshell.Services.UPower

Singleton {
  id: root

  readonly property var terminals: ({
    "kitty": "󰆍",
    "floatingterminal": "󰆍",
    "alacritty": "",
    "wezterm": "",
    "foot": "",
    "konsole": "",
    "gnome-terminal": "",
  })

  // use google material icon
  readonly property var icons: ({
    "code": "",
    // "idea": "",       
    // "waydroid": "", 
    // "eclipse": "",
    // "sublime": "",

    "google-chrome": "",
    // "firefox": "",
    // "chromium": "",
    // "brave": "󰖟",
    // "edge": "󰇩",

    "nvim": "",

    "spotify": "",
    "discord": "",
    "slack": "",
    "telegram": "",
    "signal": "󰍡",
    "whatsapp": "󰖣",
    "zoom": "",
    "teams": "󰊻",

    "mpv": "",
    "vlc": "󰕼",
    "rhythmbox": "󰓃",
    "cmus": "󰎄",
    "gimp": "",

    "inkscape": "",
    "krita": "",
    "blender": "󰂫",

    "obsidian": "󰠮",
    "logseq": "󰠮",
    "notion": "󰈄",
    "libreoffice": "󰏆",
    "zathura": "󰈦",
    "evince": "󰈦",


    "nautilus": "",
    "org.kde.dolphin": "",
    "thunar": "",
    "pcmanfm": "",
    "yazi": "",
    "ranger": "",

    "java": "",
    "python": "",
    "c": "",
    "cpp": "",
    "csharp": "",
    "java": "",
    "python": "",
    "javascript": "",
    "typescript": "",
    "go": "",
    "rust": "",
    "ruby": "",
    "php": "",
    "kotlin": "",
    "swift": "",
    "dart": "",
    "scala": "",
    "lua": "",
    "perl": "",
    "r": "",
    "matlab": "",
    "haskell": "",
    "elixir": "",
    "erlang": "",
    "zig": "",
    "nim": "",
    "julia": "",

  })

  function getRecognizedIconFromInitialClass(clz) {
    if (!clz) return [ 0, null ]

    let priorityScore = Object.keys(root.icons).length

    for (const key in icons) {
      let lowerKey = key.toLowerCase()


      if (key === clz) {
        return [ priorityScore, icons[key] ]
      }
      priorityScore = priorityScore-1
    }

    return [ 0, null ]
  }

  function getRecognizedIconFromTitle(title) {
    if (!title) return [ 0, null ]

    const lowerTitle = title.toLowerCase()

    let priorityScore = Object.keys(root.icons).length

    for (const key in icons) {
      let lowerKey = key.toLowerCase()
      const safeKey = lowerKey.replace(/[.*+?^${}()|[\]\\]/g, "\\$&")
      const re = new RegExp(`(^|[^a-z0-9])${safeKey}([^a-z0-9]|$)`, "i")


      if (re.test(lowerTitle)) {
        return [ priorityScore, icons[key] ]
      }
      priorityScore = priorityScore-1
    }

    return [ 0, null ]
  }


  readonly property var cnDigits: ({
    0: "零",
    1: "一",
    2: "二",
    3: "三",
    4: "四",
    5: "五",
    6: "六",
    7: "七",
    8: "八",
    9: "九"
  })

  readonly property var cnUnits: ["", "十", "百", "千"]
  readonly property var cnBigUnits: ["", "万", "亿", "兆"]


  function toCnNumber(num) {
    if (num === 0)
    return cnDigits[0]

    let result = ""
    let unitIndex = 0

    while (num > 0) {
      let section = num % 10000
      if (section !== 0) {
        result = convertSection(section) + cnBigUnits[unitIndex] + result
      }
      num = Math.floor(num / 10000)
      unitIndex++
    }

    result = result.replace(/^零+/, "").replace(/零+/g, "零")

    if (result.startsWith("一十"))
    result = result.slice(1)

    return result
  }

  function convertSection(num) {
    let str = ""
    let zero = false

    for (let i = 0; i < 4 && num > 0; i++) {
      let digit = num % 10
      if (digit === 0) {
        if (!zero && str.length > 0) {
          str = cnDigits[0] + str
          zero = true
        }
      } else {
        str = cnDigits[digit] + cnUnits[i] + str
        zero = false
      }
      num = Math.floor(num / 10)
    }

    return str.replace(/零$/, "")
  }


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
