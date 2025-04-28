#!/bin/bash

CSS_PATH="$HOME/.config/wofi/style.css"

chosen=$(wofi --show dmenu \
  --height=160 \
  --width=150 \
  --prompt="" \
  --cache-file=/dev/null \
  --style="$CSS_PATH" \
  << EOF
⏻ Shutdown
󰜉 Reboot
󰤄 Suspend
EOF
)

case "$chosen" in
    "⏻ Shutdown") systemctl poweroff ;;
    "󰜉 Reboot") systemctl reboot ;;
    "󰤄 Suspend") systemctl suspend ;;
    *) exit 1 ;;
esac
