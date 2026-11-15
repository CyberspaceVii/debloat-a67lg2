#!/system/bin/sh
WL=/data/adb/cyberspacevii/debloat-a67lg2
[ -f "$WL/stop_linkturbo" ] || exit 0
until [ "$(getprop sys.boot_completed)" = "1" ]; do sleep 2; done
setprop ctl.stop linkturbonative
