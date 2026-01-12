pragma Singleton
import qs.utils
import Quickshell
import Quickshell.Io
import QtQml
import QtQuick

Singleton {
  id: root

  ListModel { id: appModel }
  ListModel { id: dockModel }

  property alias model: appModel
  property alias dock: dockModel

  Process {
    running: true
    command: ["sh", "-c", `${Paths.script}/scripts/desktopapp.sh`]

    stdout: StdioCollector {
      onStreamFinished: {

        const dockSet = new Set([
          "kitty",
          "google-chrome",
          "discord",
          "spotify",
          "code",
          "org.kde.dolphin"
        ])

        function parseCSVLine(line) {
          const result = []
          let cur = ""
          let inQuotes = false

          for (let i = 0; i < line.length; i++) {
            const c = line[i]

            if (c === '"') {
              if (inQuotes && line[i + 1] === '"') {
                cur += '"'
                i++
              } else {
                inQuotes = !inQuotes
              }
            } else if (c === "," && !inQuotes) {
              result.push(cur)
              cur = ""
            } else {
              cur += c
            }
          }

          result.push(cur)
          return result
        }

        function getImageExtension(path) {
          if (!path || path === "null") return null
          const dot = path.lastIndexOf(".")
          if (dot === -1) return null
          const ext = path.substring(dot + 1).toLowerCase()
          const supported = ["png","jpg","jpeg","bmp","gif","svg","webp"]
          return supported.includes(ext) ? ext : null
        }

        function getDesktopId(path) {
          if (!path) return null
          let name = path.substring(path.lastIndexOf("/") + 1)
          if (name.endsWith(".desktop"))
            name = name.slice(0, -8)
          return name
        }

        const lines = this.text.trim().split("\n")

        lines.forEach(line => {
          const fields = parseCSVLine(line)
          if (fields.length < 5) return

          const iconPath = fields[4]
          const desktopPath = fields[0]
          const desktopId = getDesktopId(desktopPath)

          const item = {
            desktopFile: desktopPath,
            desktopId: desktopId,
            name: fields[1],
            terminal: fields[2] === "true",
            execc: fields[3],
            icon: iconPath === "null" ? null : iconPath,
            iconExt: getImageExtension(iconPath)
          }

          appModel.append(item)

          if (dockSet.has(desktopId)) {
            dockModel.append(item)
          }
        })
      }
    }
  }
}

