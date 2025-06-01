#!/bin/bash

# --- Configurações de Caminho ---
KITTY_CONFIG="$HOME/.config/kitty/appearance.conf"
FASTFETCH_CONFIG="$HOME/.config/fastfetch/config.jsonc"
ASCII_LOGO_PATH="$HOME/.config/fastfetch/linux_ascii.txt"

# --- Extração da cor de destaque do Kitty ---
# Tenta pegar a cor da linha 'color4' (comum para destaque em temas)
DYNAMIC_COLOR=$(grep -E '^color4\s+' "$KITTY_CONFIG" | awk '{print $2}' | tr -d '\r')

# Fallback para a cor 'foreground' se 'color4' não for encontrado ou estiver vazio
if [ -z "$DYNAMIC_COLOR" ]; then
    DYNAMIC_COLOR=$(grep -E '^foreground\s+' "$KITTY_CONFIG" | awk '{print $2}' | tr -d '\r')
fi

# Fallback para uma cor padrão se nenhuma for encontrada (muito improvável, mas garante)
if [ -z "$DYNAMIC_COLOR" ]; then
    DYNAMIC_COLOR="#A7C080" # Cor padrão que você estava usando
fi

# --- Geração do arquivo config.jsonc com a cor dinâmica ---
cat << EOF > "$FASTFETCH_CONFIG"
{
    "logo": {
        "type": "file",
        "source": "$ASCII_LOGO_PATH",
        "color": {"1": "$DYNAMIC_COLOR"}
    },
    "display": {
        "separator": "➜    ",
        "color": {
            "keys": "$DYNAMIC_COLOR",  // Cor das chaves (OS, PC, etc.)
            "values": "default"        // Cores dos valores (padrão do terminal)
        }
    },
    "modules": [
        {
            "key": "| OS         ",
            "type": "os"
        },
        {
            "key": "| PC         ",
            "type": "host"
        },
        {
            "key": "| Uptime     ",
            "type": "uptime"
        },
        {
            "key": "| Packages   ",
            "type": "packages"
        },
        {
            "key": "| CPU        ",
            "type": "cpu"
        },
        {
            "key": "| RAM        ",
            "type": "memory"
        },
        {
            "key": "| Disk       ",
            "type": "disk"
        }
    ]
}
EOF

# --- Executa o Fastfetch com a nova configuração ---
fastfetch
