#!/usr/bin/env bash
set -euo pipefail

THEME="$1"
REPO="$HOME/dotfiles"
CACHE_DIR="$HOME/.cache/dotswap"
CURRENT_FILE="$CACHE_DIR/current_theme"

mkdir -p "$CACHE_DIR"

if [[ ! -d "$REPO/$THEME" ]]; then
    echo "Theme '$THEME' not found."
    exit 1
fi

if [[ -f "$CURRENT_FILE" ]]; then
    OLD_THEME="$(<"$CURRENT_FILE")"
    if [[ "$OLD_THEME" != "$THEME" ]]; then
        CURRENT_WP="$(swww query | grep 'image:' | head -n1 | awk -F'image: ' '{print $2}' | xargs realpath || true)"
        [[ -n "${CURRENT_WP:-}" && -f "$CURRENT_WP" ]] && echo "$CURRENT_WP" > "$CACHE_DIR/${OLD_THEME}.last"
        stow -d "$REPO" -D "$OLD_THEME"
    fi
fi

stow -d "$REPO" "$THEME"
echo "$THEME" > "$CURRENT_FILE"

WALLPAPER_CACHE="$CACHE_DIR/${THEME}.last"
WALLPAPER_DIR="$REPO/$THEME/Wallpapers"

if [[ -d "$WALLPAPER_DIR" ]]; then
    if [[ -f "$WALLPAPER_CACHE" && -f "$(cat "$WALLPAPER_CACHE")" ]]; then
        WP="$(<"$WALLPAPER_CACHE")"
    else
        WP="$(find "$WALLPAPER_DIR" -type f | shuf -n1)"
        echo "$WP" > "$WALLPAPER_CACHE"
    fi
    swww img "$WP"
fi

hyprpanel -q; hyprpanel & disown

pkill -USR1 kitty 2>/dev/null || true
exec kitty @ load-config 2>/dev/null || source ~/.zshrc 2>/dev/null || true

echo "Theme '$THEME' applied."

