#!/bin/bash

STATE_FILE="/tmp/waybar_network_mode"
MODE="normal"

# Alternar modo ao receber sinal via clique
if [ "$1" = "toggle" ]; then
    if [ -f "$STATE_FILE" ] && grep -q "alt" "$STATE_FILE"; then
        echo "normal" > "$STATE_FILE"
    else
        echo "alt" > "$STATE_FILE"
    fi
    # Após alternar, seguir adiante para mostrar o novo estado
fi

# Lê o modo atual
if [ -f "$STATE_FILE" ]; then
    MODE=$(cat "$STATE_FILE")
fi

# Wi-Fi ativo?
WIFI_INFO=$(nmcli -t -f ACTIVE,SSID,SIGNAL dev wifi | grep '^yes' | head -n1)
if [ -n "$WIFI_INFO" ]; then
    SSID=$(echo "$WIFI_INFO" | cut -d: -f2)
    SIGNAL=$(echo "$WIFI_INFO" | cut -d: -f3)

    if [ "$SIGNAL" -ge 75 ]; then
        ICON="󰤨"
    elif [ "$SIGNAL" -ge 50 ]; then
        ICON="󰤥"
    elif [ "$SIGNAL" -ge 25 ]; then
        ICON="󰤢"
    else
        ICON="󰤟"
    fi

    if [ "$MODE" = "alt" ]; then
        TEXT="$ICON $SSID"
    else
        TEXT="$ICON"
    fi

    echo "{\"text\": \"$TEXT\", \"class\": \"wifi\"}"
    exit 0
fi

# Ethernet?
ETH_CONNECTED=$(nmcli -t -f DEVICE,TYPE,STATE dev | grep ':ethernet:connected')
if [ -n "$ETH_CONNECTED" ]; then
    INTERFACE=$(nmcli -t -f DEVICE,TYPE,STATE dev | awk -F: '$3=="connected"{print $1; exit}')
    IP=$(ip -4 addr show "$INTERFACE" | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

    if [ "$MODE" = "alt" ]; then
        TEXT="󰈀 $IP"
    else
        TEXT="󰈀"
    fi

    echo "{\"text\": \"$TEXT\", \"class\": \"ethernet\"}"
    exit 0
fi

echo "{\"text\": \"󰖪\", \"class\": \"disconnected\"}"

