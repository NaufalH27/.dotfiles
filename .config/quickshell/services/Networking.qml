pragma Singleton
import Quickshell
import Quickshell.Io
import QtQml
import QtQuick

Singleton {
  id:root
  ListModel {
      id: wifiDeviceModel
  }
  ListModel {
      id: ethernetDeviceModel
  }

  ListModel {
      id: vpnDeviceModel
  }

  property alias wifiDevice: wifiDeviceModel
  property alias ethernetDevice: ethernetDeviceModel
  property alias vpnDevice: vpnDeviceModel
  property var topNetwork: null

  Process {
    running: true
    command: [ "nmcli", "monitor" ]

    stdout: SplitParser {
      onRead: (line) => {
        networkInfo.running = true
      }
    }
  }

  Process {
    id: networkInfo
    running: false
    command:["sh","-c",  "nmcli -t -f DEVICE,TYPE,STATE,CONNECTION device status | while IFS=: read -r d t s c; do m=$(ip route show default dev $d 2>/dev/null | awk '{print $NF}'); echo $d:$t:$s:$c:$m; done"]
    stdout: StdioCollector {
      onStreamFinished: {
        root.topNetwork = null
        const lines = this.text.trim().split("\n")

        lines.forEach(line => {
          const parts = line.split(":")

          let obj = {
            device: parts[0],
            type: parts[1],
            state: parts[2],
            connection: parts[3] || "",
            metric: parts[4]
          }
          if (obj.type === "wifi") {
            root.wifiDevice.append(obj)
            if ((root.topNetwork === null || obj.metric < root.topNetwork.metric) && Number(obj.metric)) {
              root.topNetwork = obj
            }
          }

          else if(obj.type === "ethernet") {
            root.ethernetDevice.append(obj)
            if ((root.topNetwork === null || obj.metric < root.topNetwork.metric) && Number(obj.metric)) {
              root.topNetwork = obj
            }
          }

          else if(parts[1] === "vpn") { 
            root.vpnDevice.append(obj)
          }
        })

      }
    }
  }
}
