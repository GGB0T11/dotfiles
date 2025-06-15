#!/bin/bash

# Alternar mute via clique
if [[ "$1" == "toggle" ]]; then
    STATUS=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)
    if [[ "$STATUS" == *"[MUTED]"* ]]; then
        wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 0
        echo '{"text": "", "class": "unmuted"}'
    else
        wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 1
        echo '{"text": "󰍭", "class": "muted"}'
    fi
    exit 0
fi

# Execução padrão (para waybar chamar no início)
STATUS=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)
if [[ "$STATUS" == *"[MUTED]"* ]]; then
    echo '{"text": "󰍭", "class": "muted"}'
else
    echo '{"text": "", "class": "unmuted"}'
fi

