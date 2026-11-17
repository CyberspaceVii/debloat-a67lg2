# Changelog

## v0.4 — 2026-11-17

- Support older 1784605054 and newer 1790133188 firmware in one package.
- Pair RuntimeTest removal with its newly added companion overlay.
- Preserve previous selections, including v0.3 installations, during updates.
- Cover reviewed paths before an OTA adds them; keep boot-time settings with the module.
- Back up selected apps and remove surviving updated copies using verified APK signers,
  key-rotation lineage, split-aware content checks and a version-guarded uninstall.
- Retain backups, replacements and failed cleanup work; retry failures on later boots.

- Use KernelSU's custom installer protocol with the configuration script kept
  separate from the reserved legacy install.sh filename.

## v0.3

Choose which preinstalled apps to disable on the Foxxd A67L Gen 2.
