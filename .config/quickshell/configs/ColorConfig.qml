import Quickshell.Io

JsonObject {
    property Primary primary: Light {}

    component Primary: JsonObject {
        property string base: "#faf4ed"
        property string surface: "#ebeaec"
        property string overlay: "#e4e2e5"

        property string muted: "#9790A0"
        property string subtle: "#696969"
        property string text: "#5b4f56"
        property string contrast: "#544b5d"

        property string red: "#c91c60"
        property string blue: "#353d61"
        property string green: "#38615b"
        property string yellow: "#d6b36a"
        property string purple: "#58376c"
        property string highlightLow: ""
        property string highlightMedium: "#d9d7dc"
    }

    component Light: Primary {
        base: "#ffffff"
        surface: "#ffffff"
        overlay: "#ffffff"

        muted: "#9790A0"
        subtle: "#696969"
        text: "#5b4f56"
        contrast: "#544b5d"

        red: "#c91c60"
        blue: "#353d61"
        green: "#8bb57b"
        purple: "#58376c"
        yellow: "#d6b36a"
        highlightMedium: "#d9d7dc"
    }
    component Dark: Primary {
        base: "#faf4ed"
        surface: "#ebeaec"
        overlay: "#e4e2e5"

        muted: "#9790A0"
        subtle: "#696969"
        text: "#726A81"
        contrast: "#544b5d"

        red: "#c91c60"
        blue: "#353d61"
        green: "#38615b"
        purple: "#58376c"
    }
}
