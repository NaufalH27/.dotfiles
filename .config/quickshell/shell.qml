import Quickshell
import "modules/bar"
import "modules/dock"

Scope {
  Bar{}

  BottomBar {
    id:bottomBar
  }
  Dock{
    barHeight: bottomBar.barHeight-1
  }
}
