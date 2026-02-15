pragma Singleton

import qs.utils
import qs.services
import Quickshell
import Quickshell.Io

Singleton {
  id: root

  property alias color: adapter.color
  property alias system: adapter.system

  ElapsedTimer {
    id: timer
  }

  FileView {
    path: `${Paths.config}/shell.json`
    watchChanges: true

    onAdapterUpdated: writeAdapter()

    onFileChanged: {
      timer.restart();
      reload();
    }

    onLoaded: {
      try {
        JSON.parse(text());

        console.info(
          `[Config] Loaded successfully in ${timer.elapsedMs()}ms`
        );
        DesktopApp.refetchIcon.running = true
        Hypr.updateWorkspaceModel()

      } catch (e) {
        console.error(
          "[Config] Failed to load config:",
          e.message
        );
      }
    }

    onLoadFailed: err => {
      if (err === FileViewError.FileNotFound) {
        console.info(
          "[Config] writing new config entry",
        );
        writeAdapter()
      } else {
        console.warn(
          "[Config] Failed to read config file:",
          FileViewError.toString(err)
        );
      }
    }

    onSaveFailed: err => {
      console.error(
        "[Config] Failed to save config file:",
        FileViewError.toString(err)
      );
    }

    JsonAdapter {
      id: adapter

      property ColorConfig color: ColorConfig {}
      property SystemConfig system: SystemConfig {}
    }
  }

}
