#!/system/bin/sh
[ "$(getprop ro.product.device)" = A67L_Gen2 ] || abort "Fail! This module is for the Foxxd A67L Gen 2."
[ "$KSU" = true ] || abort "Fail! KernelSU Next is required."


TIMEOUT=10

getkey() {
  f="$MODPATH/.kev"; ans="no"; n=0; max=$(( $1 * 10 ))
  : > "$f"
  getevent -lq > "$f" 2>/dev/null &
  gp=$!
  while [ "$n" -lt "$max" ]; do
    if grep -q KEY_VOLUMEUP "$f" 2>/dev/null; then ans="yes"; break; fi
    if grep -q KEY_VOLUMEDOWN "$f" 2>/dev/null; then ans="no"; break; fi
    sleep 0.1; n=$(( n + 1 ))
  done
  kill "$gp" 2>/dev/null
  rm -f "$f"
  echo "$ans"
}

item() {
  ui_print "Remove $1?"
  if [ "$(getkey "$TIMEOUT")" = "yes" ]; then
    ok=1
    for p in $2; do
      mkdir -p "$MODPATH/$(dirname "$p")" || ok=0
      mknod "$MODPATH/$p" c 0 0 2>/dev/null && chmod 644 "$MODPATH/$p" || ok=0
    done
    [ -n "$3" ] && pm uninstall-system-updates "$3" >/dev/null 2>&1
    [ "$4" = "lt" ] && : > "$WL/stop_linkturbo"
    [ "$4" = "face" ] && : > "$WL/facelock_off"
    if [ "$ok" = 1 ]; then ui_print "Success!"; else ui_print "Fail!"; fi
  else
    ui_print "Skipped"
  fi
}

WL=/data/adb/cyberspacevii/debloat-a67lg2
mkdir -p "$WL"
rm -f "$WL/stop_linkturbo" "$WL/facelock_off"

ui_print "Debloat CyberspaceVII"
ui_print " "
ui_print "Volume Up = Yes, Volume Down = No (No after ${TIMEOUT}s)"
ui_print " "

item "TikTok (com.tiktok.lite.go)"            "system/app/TikTok64"
item "AirTalk (com.hugoteam.airtalk_wireless)" "system/app/AirTalk"        "com.hugoteam.airtalk_wireless"
item "AirVoice (com.hth.airvoice_wireless)"    "system/app/AirVoice"       "com.hth.airvoice_wireless"
item "TagMobile (com.hthcomm.tagmobile)"       "system/app/TagMobile"      "com.hthcomm.tagmobile"
item "AirVoice Welcome (com.airtalk.welcome)"  "system/app/AirVoiceWelcom"
item "Face Unlock (cn.heils.faceunlock)"       "system/priv-app/HeilFaceUnlockT" "" "face"
item "LinkTurbo (com.sprd.linkturbo)"          "system/system_ext/app/LinkTurbo" "" "lt"
item "RuntimeTest (com.sprd.runtime)"          "system/system_ext/app/RuntimeTest"
item "ValidationTools (com.sprd.validationtools)" "system/product/app/ValidationTools system/product/overlay/ValidationTools__ussi_arm64_go__auto_generated_rro_product.apk"
item "CameraCalibration (com.sprd.cameracalibration)" "system/product/app/CameraCalibration"
item "CamTa (com.sprd.camta)"                  "system/product/app/CamTa"
item "TuiAuxiService (com.unisoc.tui)"         "system/product/app/TuiAuxiService"
item "IFAA Manager (org.ifaa.aidl.manager)"    "system/product/app/IfaaManagerService"
item "Soter Service (com.tencent.soter.soterserver)" "system/product/app/SoterService"
item "Omacp (com.sprd.omacp)"                  "system/product/priv-app/Omacp"
item "SGPS (com.spreadtrum.sgps)"              "system/vendor/app/SGPS"
item "UASetting (com.sprd.uasetting)"          "system/vendor/app/UASetting"
