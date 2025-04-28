#!/bin/bash

# Verifica o estado de energia
if acpi -a | grep -q "off-line"; then
    CONFIG="$HOME/.config/hypr/hypridle_battery.conf"
else
    CONFIG="$HOME/.config/hypr/hypridle_charger.conf"
fi

# Encerra instâncias anteriores do Hypridle
pkill hypridle

# Inicia o Hypridle com o arquivo de configuração adequado
hypridle --config "$CONFIG" &

