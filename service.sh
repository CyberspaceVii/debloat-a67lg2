#!/system/bin/sh
MODPATH=$(dirname "$0")
WL=/data/adb/cyberspacevii/debloat-a67lg2
. "$MODPATH/lib.sh"
until [ "$(getprop sys.boot_completed)" = 1 ]; do sleep 2; done
[ ! -f "$MODPATH/lt" ] || setprop ctl.stop linkturbonative
prepare_state || exit 1
# One sweep per boot, including after an OTA; failed removals stay pending.
cleanup_targets >> "$WL/cleanup.log" 2>&1
