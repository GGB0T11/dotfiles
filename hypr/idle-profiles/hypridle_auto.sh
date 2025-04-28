#!/bin/bash

BATT_CONF="$HOME/.config/hypr/idle-profiles/hypridle_battery.conf"
CHRG_CONF="$HOME/.config/hypr/idle-profiles/hypridle_charger.conf"

# Detecta se está no carregador
if [ "$(cat /sys/class/power_supply/ADP0/online)" -eq 1 ]; then
    echo "No carregador. Aplicando config de carregador..."
    pkill hypridle
    hypridle -c "$CHRG_CONF" &
else
    echo "Na bateria. Aplicando config de bateria..."
    pkill hypridle
    hypridle -c "$BATT_CONF" &
fi

