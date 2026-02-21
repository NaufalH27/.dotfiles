import Quickshell.Io

JsonObject {
  property Clock clock: Clock {}
  property Workspace workspace: Workspace {}
  property Dock dock: Dock {}
  property Image image: Image {}


  component Clock: JsonObject {
    // 0 is 24hour without a date
    // 1 is ampm without a date
    // 2 is 24hour with a date
    // 3 is ampm with a date
    property int clockFormat: 2
  }

  component Workspace: JsonObject {
    property int minNumberOfPillShown: 5
    // property int maxNumberOfPillShown: 10
    property int minimizedWorkspaceOffset: 100
  }

  component Dock: JsonObject {
    property bool showAllApps: false
    property list<string> apps: [
      "kitty",
      "code",
      "chromium-browser",
      "com.obsproject.Studio",
      "spotify",
      "discord",
      "org.gnome.Nautilus"
    ]

  }

  component Image: JsonObject {
      property string profilePicture: ""
      property string defaultPlayerCover: ""
  }

}
