#!/system/bin/sh
MODPATH=$(dirname "$0")
[ -f "$MODPATH/face" ] || exit 0
RESETPROP=resetprop
command -v resetprop >/dev/null 2>&1 || RESETPROP=/data/adb/ksu/bin/resetprop
"$RESETPROP" heils.facelock 0
