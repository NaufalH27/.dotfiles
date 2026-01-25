pragma Singleton
import qs.utils
import Quickshell
import Quickshell.Io
import QtQml
import QtQuick

Singleton {
  id: root
  property bool ready: false

  ListModel { id: appModel }
  ListModel { id: dockModel }

  property alias model: appModel
  property alias dock: dockModel

  property var appById: ({})

  function getAppByDesktopId(id) {
    return appById[id] || null
  }

  Process {
    running: true
    command: ["sh", "-c", `${Paths.script}/scripts/desktopapp.sh -n WhiteSur`]

    stdout: StdioCollector {
      onStreamFinished: {

        const dockOrder = [
          "kitty",
          "code",
          "chromium-browser",
          "com.obsproject.Studio",
          "spotify",
          "discord",
          "org.gnome.Nautilus"
        ]

        const dockIndex = {}
        dockOrder.forEach((id, i) => dockIndex[id] = i)

        const dockItems = []

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

        function getDesktopId(path) {
          if (!path) return null
          let name = path.substring(path.lastIndexOf("/") + 1)
          if (name.endsWith(".desktop"))
            name = name.slice(0, -8)
          return name
        }

        appModel.clear()
        dockModel.clear()
        root.appById = ({})

        const lines = this.text.trim().split("\n")

        lines.forEach(line => {
          const fields = parseCSVLine(line)
          if (fields.length < 5) return

          const desktopPath = fields[0]
          const desktopId = getDesktopId(desktopPath)
          if (!desktopId) return

          const item = {
            deskAppByDesktopIdtopFile: desktopPath,
            desktopId: desktopId,
            name: fields[1],
            terminal: fields[2] === "true",
            execc: fields[3],
            icon: fields[4] === "null" ? null : fields[4],
          }

          appModel.append(item)
          root.appById[desktopId] = item

          if (dockIndex[desktopId] !== undefined) {
            dockItems.push(item)
          }
        })

        dockItems
          .sort((a, b) => dockIndex[a.desktopId] - dockIndex[b.desktopId])
          .forEach(item => dockModel.append(item))

        root.ready = true
      }
    }
  }
}

