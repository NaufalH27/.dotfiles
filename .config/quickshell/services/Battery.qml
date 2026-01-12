
pragma Singleton

import Quickshell
import Quickshell.Services.UPower
import QtQml

Singleton {
  id: root
  property var device: UPower.displayDevice
  property bool isLaptopBattery: device.isLaptopBattery
  property real levelPercentage: UPower.displayDevice.percentage

}
