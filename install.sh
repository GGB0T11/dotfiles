#!/bin/bash

info() { echo -e "\e[1;34m[INFO]\e[0m $*"; }
success() { echo -e "\e[1;32m[SUCCESS]\e[0m $*"; }
error() { echo -e "\e[1;31m[ERROR]\e[0m $*"; }

verify_distro() {
    if [[ ! -f /etc/arch-release ]]; then
        error "This script only works on Arch-based distros."
        exit 1
    fi
}

verify_dots() {
    if [[ ! -d "$HOME/dotfiles" ]]; then
        info "Cloning dotfiles $HOME..."
        git clone https://github.com/GGB0T11/dotfiles.git "$HOME"
        success "Dotfiles cloned."
    else
        info "Dotfiles already cloned."
    fi
}

install_pkgs() {
    PACMAN_PKGS=(
        git stow kitty swww hyprland hyprlock kitty zsh neovim
        btop superfile wofi fastfetch waybar wpctl brightnessctl
        playerctl grimblast bluez bluez-utils networkmanager
        power-profiles-daemon
        )

    YAY_PKGS=(
        brave-bin nerd-fonts-fira-code
        )

    if ! command -v yay &>/dev/null; then
        info "Yay not found, installing..."
        sudo pacman -S yay --noconfirm
        success "Yay installed."
    fi
    info "Installing pacman packages..."
    sudo pacman -S --noconfirm --needed "${PACMAN_PKGS[@]}"
    
    info "Installing yay packages"
    yay -S --noconfirm --needed "${YAY_PKGS[@]}"
}

verify_targets() {
    BACKUP_DIR="$HOME/dotbackup"
    mkdir $BACKUP_DIR

    for dir in hypr hyprpanel kitty fastfetch wofi; do
        target="$HOME/.config/$dir"
        if [[ -e "$target" && ! -L "$target" ]]; then
            echo "Moving $target to $BACKUP_DIR"
            mv "$target" "$BACKUP_DIR/"
        fi
    done
    
    if [[ -e "$HOME/Wallpapers" && ! -L "$HOME/Wallpapers" ]]; then
        echo "Moving $target to $BACKUP_DIR"
        mv "$target" "$BACKUP_DIR/"
    fi
    
    for file in .zshrc .p10k.zsh; do
        target="$HOME/$file"
        if [[ -e "$target" && ! -L "$target" ]]; then
            echo "Moving $target to $BACKUP_DIR"
            mv "$HOME/Wallpapers" "$BACKUP_DIR/"
        fi
    done
}

configure_services() {
    sudo systemctl disable systemd-resolved
    sudo systemctl disable systemd-networkd
    sudo systemctl enable NetworkManager
    sudo systemctl start NetworkManager   
    sudo systemctl enable bluetooth
    sudo systemctl start bluetooth
}

apply_dot() {
    info "Applying base dotfiles..."
    stow -d "$HOME/dotfiles" base
    success "Base applied."
    
    info "Applying the default theme..."
    bash "$HOME/dotfiles/swap-theme.sh default"
    success "Theme applied."
    
    if [[ "$SHELL" != "$(which zsh)" ]]; then
        info "Changing default shell to ZSH..."
        chsh -s "$(which zsh)"
        success "Shell changed."
    fi
}

main() {
    verify_distro
    verify_dots
    install_pkgs
    verify_targets
    configure_services
    apply_dot
}

main

