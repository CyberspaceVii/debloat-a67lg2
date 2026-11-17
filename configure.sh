ui_print "Debloat CyberspaceVII"
ui_print " "
reuse=no
if [ -d "$ACTIVE" ]; then
  ui_print "Keep previous choices? Up = keep, Down = choose again (keep after 10s)."
  [ "$(getkey 10)" = down ] || reuse=yes
fi
: > "$MODPATH/selections"
: > "$MODPATH/selected-targets"
while IFS='|' read -r pkg label paths hook; do
  selected=no
  if [ "$reuse" = yes ]; then
    saved=$(setting "$ACTIVE/selections" "$pkg")
    case "$saved" in
      yes|no) selected=$saved;;
      *) previously_removed "$paths" && selected=yes;;
    esac
  else
    ui_print "Remove $label ($pkg)? Up = remove, Down = keep (keep after 10s)."
    [ "$(getkey 10)" = up ] && selected=yes
  fi
  echo "$pkg=$selected" >> "$MODPATH/selections"
  if [ "$selected" = yes ]; then
    echo "$pkg|$label|$paths|$hook" >> "$MODPATH/selected-targets"
  fi
done < "$MODPATH/targets.txt"
prepare_targets || abort "Fail! Could not back up or cover a selected app; existing choices kept."
ui_print "Reboot to apply. Updated copies are checked after boot; backups are retained."
