# Debloat

**[Download the current release](https://github.com/CyberspaceVii/debloat-a67lg2/releases/latest/download/debloat-a67lg2.zip)**

Pick which preinstalled carrier apps and factory tools to remove from the
Foxxd A67L Gen 2 with KernelSU Next.

## Firmware and choices

Supports the older **1784605054** firmware and **1790133188**. The same module
covers both; there is no firmware switch. The RuntimeTest and ValidationTools
choices also cover their companion overlays. Reviewed paths absent on older
firmware remain covered if an OTA adds them later.

On a fresh install, **Volume Up = remove**, **Volume Down = keep**. A 10-second
timeout keeps the app. Choices are:

TikTok Lite · AirTalk · AirVoice · TagMobile · AirVoice Welcome · Face Unlock ·
LinkTurbo · RuntimeTest · ValidationTools · CameraCalibration · CamTa ·
TuiAuxiService · IFAA Manager · Soter Service · Omacp · SGPS · UASetting

When updating, the installer first offers to **keep your previous choices**.
Up or a 10-second timeout keeps them; Down starts a fresh survey. This also
recognizes selections from v0.3. Each staged update holds its own choices;
a failed installation leaves the active module's configuration intact.

Face Unlock removal also turns off its system property. LinkTurbo removal
also stops its background service. Stock partitions are never written.

## Updated apps and backups

A Play-updated app can survive hiding its stock directory. After boot, the
module checks selected packages and removes such copies only when the actual
APK's signing identity matches the reviewed stock package or its verified key
rotation lineage. Replacements and unrecognized signers are kept and logged.

Selected stock apps are backed up before installation completes. Updated copies
are backed up before cleanup as well. Backup failure stops installation or
leaves runtime cleanup pending for the next boot; an incomplete backup never
authorizes removal. Package contents and version are rechecked before removal.
Checks repeat after each boot, including an OTA boot.

Backups live in `/data/adb/cyberspacevii/debloat-a67lg2/backups/<package>/<fingerprint>/`.
They contain numbered base/split APKs, an APK-path manifest and any owner user's
credential/device-encrypted app data available at backup time. These are live
file copies, not guaranteed transaction-consistent application snapshots.
They remain after uninstall; delete them yourself when no longer needed.
Older state is retained until module removal.

Status: `/data/adb/cyberspacevii/debloat-a67lg2/cleanup.log` and
`cleanup-pending`. Pending entries retry at the next boot. A stock APK still
visible there indicates a mount problem. An unrecognized signer is left for
manual review. Additional Android users' app data is outside the backup scope;
updated-copy removal applies device-wide.

## Install and undo

1. Install the ZIP through KernelSU Next and choose what to remove.
2. Reboot normally to apply the staged module.

Disable or remove the module and reboot to reveal the stock apps again. Hidden
apps' data may have been discarded by Android. Removed Play updates do not
return automatically; update restored apps through the Play Store, or copy all saved APKs from a private backup to your computer using root
access and run `adb install-multiple -r <local-backup-directory>/*.apk`.
App-data restoration is manual and needs correct ownership/SELinux labels;
backups are never restored over a replacement app automatically.

## Build and validation

Build the module from the checked-in source with:

```sh
python build.py --output /tmp/debloat-a67lg2.zip
python tests/test_module.py
```

The builder uses `ANDROID_SDK_ROOT` (default `/opt/android-sdk`), with
`ANDROID_JAR`, `D8`, and `JAVAC` overrides for other toolchain locations.
See [VALIDATION.md](VALIDATION.md) for the tested scope.

## License

[WTFPL](LICENSE).

CyberspaceVII · https://www.cyberspace7.org
