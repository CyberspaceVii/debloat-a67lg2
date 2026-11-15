#!/system/bin/sh
WL=/data/adb/cyberspacevii/debloat-a67lg2
[ -f "$WL/facelock_off" ] || exit 0
RESETPROP=resetprop; command -v resetprop >/dev/null 2>&1 || RESETPROP=/data/adb/ksu/bin/resetprop
"$RESETPROP" heils.facelock 0
