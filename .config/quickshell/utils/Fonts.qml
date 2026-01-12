pragma Singleton
import Quickshell
import QtQuick

Singleton {
    id: root
  FontLoader {
    id: sfprofont
    source: "/usr/share/fonts/SFPro/SF-Pro-Text-Regular.otf"
  }
  FontLoader {
    id: materialfont
    source: "/usr/share/fonts/material-symbol-fonts/MaterialSymbolsRounded[FILL,GRAD,opsz,wght].ttf"
  }

  FontLoader {
    id: mapleMonofont
    source: "/usr/share/fonts/MapleMono/MapleMonoNL-CN-Regular.ttf"
  }
  FontLoader {
    id: shipporiMincho
    source: "/usr/share/fonts/shippori-mincho/ShipporiMincho-Regular.ttf"
  }
  property alias sans: sfprofont.font.family
  property alias mono: mapleMonofont.font.family
  property alias material: materialfont.font.family
  property alias chinesejp: shipporiMincho.font.family

}
