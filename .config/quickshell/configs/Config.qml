pragma Singleton

import qs.utils
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property alias font: adapter.font
    property alias palette: adapter.palette
    property alias utility: adapter.utility
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

                if (adapter.utility.toast.configLoaded) {
                    console.info(
                        `[Config] Loaded successfully in ${timer.elapsedMs()}ms`
                    );
                }
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

            property FontConfig font: FontConfig {}
            property PaletteConfig palette: PaletteConfig {}
            property UtilityConfig utility: UtilityConfig {}
            property SystemConfig system: SystemConfig {}
        }
    }

}
