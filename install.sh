#!/usr/bin/env bash
set -euo pipefail

info() { echo -e "\e[1;34m[INFO]\e[0m $*"; }
success() { echo -e "\e[1;32m[SUCCESS]\e[0m $*"; }
error() { echo -e "\e[1;31m[ERROR]\e[0m $*"; }

if [[ ! -f /etc/arch-release ]]; then
    error "This script only works on Arch-based distros."
    exit 1
fi

for dir in hypr hyprpanel kitty fastfetch wofi; do
    target="$HOME/.config/$dir"
    if [[ -e "$target" && ! -L "$target" ]]; then
        error "$target already exists, remove or backup it."
        exit 1
    fi
done

if [[ -e "$HOME/Wallpapers" && ! -L "$HOME/Wallpapers" ]]; then
    error "$HOME/Wallpapers already exists, remove or backup it."
    exit 1
fi

for file in .zshrc .p10k.zsh; do
    target="$HOME/$file"
    if [[ -e "$target" && ! -L "$target" ]]; then
        error "$target already exists, remove or backup it."
        exit 1
    fi
done

if ! command -v yay &>/dev/null; then
    info "Installing Yay..."
    sudo pacman -S yay --noconfirm
    success "Yay installed."
fi

info "Installing essentials..."
sudo pacman -S --needed --noconfirm git stow swww hyprland kitty zsh neovim wget curl
yay -S --noconfirm hyprpanel
success "Essentials installed."

if [[ ! -d "$HOME/dotfiles" ]]; then
    info "Cloning dotfiles..."
    git clone https://github.com/GGB0T11/dotfiles.git ~/
    success "Dotfiles cloned."
else
    info "Dotfiles already cloned."
fi

info "Installing fonts..."
yay -S nerd-fonts-fira-code
success "Fonts installed."

info "Available themes:"
themes=($(find "$HOME/dotfiles" -mindepth 1 -maxdepth 1 -type d -exec basename {} \ | grep -vE '^(base|scripts)$'))

echo
for i in "${!themes[@]}"; do
    echo "[$i] ${themes[$i]}"
done
echo

read -rp "Select a theme by number: " theme_index

if [[ ! "$theme_index" =~ ^[0-9]+$ ]] || (( theme_index < 0 || theme_index >= ${#themes[@]} )); then
    error "Invalid selection."
    exit 1
fi

THEME_DEFAULT="${themes[$theme_index]}"
info "Theme selected: $THEME_DEFAULT"

info "Applying base dotfiles..."
stow -d "$HOME/dotfiles" base
success "Base applied."

info "Applying theme '$THEME_DEFAULT'..."
bash "$HOME/dotfiles/scripts/swap-theme.sh" "$THEME_DEFAULT"
success "Theme applied."

if [[ "$SHELL" != "$(which zsh)" ]]; then
    info "Changing default shell to ZSH..."
    chsh -s "$(which zsh)"
    success "Shell changed."
fi

success "Installation completed. Restart your PC."

