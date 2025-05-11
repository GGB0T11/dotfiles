# More one dotfile
this repository was made as a way to manage and gather my favorite themes, use the way you want.

---

## Folder Structure
```
base
├── .config
│   ├── hypr
│   │   ├── hyprland.conf
│   │   └── switch_wallpaper.sh
│   ├── kitty
│   │   └── kitty.conf
│   └── nvim
│   ├── init.lua
│   ├── lazy-lock.json
│   ├── lua
│   │   ├── config
│   │   │   ├── autocommands.lua
│   │   │   ├── keymaps.lua
│   │   │   ├── lazy.lua
│   │   │   └── options.lua
│   │   └── plugins
│   │   ├── appearance.lua
│   │   ├── completions.lua
│   │   ├── debugging.lua
│   │   ├── lsp.lua
│   │   ├── navigation.lua
│   │   └── utils.lua
│   └── .luarc.json
├── .p10k.zsh
└── .zshrc

theme
├── .config
│   ├── fastfetch
│   │   ├── config.jsonc
│   │   └── linux_ascii.txt
│   ├── hyprpanel
│   │   ├── config.json
│   │   ├── modules.json
│   │   └── modules.scss
│   ├── kitty
│   │   └── appearance.conf
│   └── wofi
│       └── style.css
└── Wallpapers
```
---

## Base vs Theme
- `base/`: technical configuration shared across all themes
- `theme/`: individual themes with their appearance files and wallpapers

## Usage
1. Make sure you backed up your .config before running this script (if there are already folders with the same name the script will not work)
1. run the dotfile.sh whit --theme

