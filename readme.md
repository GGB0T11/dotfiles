# More one dotfile
this repository was made as a way to manage and gather my favorite themes, use the way you want.

## EXTREMELY SERIOUS LEGAL DISCLAIMER (but not that serious)

By using these dotfiles, you agree to the following absurd terms:

---

### CATACLYSMIC DISCLAIMER

The creator of these dotfiles is **NOT** responsible for:

- The initiation of World War III
- Computers that suddenly decide to explode, implode, or transcend to another dimension
- Excessive tears (yours, your family's, or your computer's)
- Interdimensional portals that may appear in your terminal
- Your cat developing programming skills superior to yours
- Spilled coffee mysteriously forming apocalyptic symbols
- Your operating system developing consciousness and questioning your life choices
- Changes in Earth's rotation due to extremely efficient processing
- Neighbors revolting because of the absurd speed of your terminal

### POSSIBLE SIDE EFFECTS

Users have reported:
- Productivity so high that coworkers suspect supernatural pacts
- Addiction to environment customization (treatment available)
- Inability to use "normal" computers without physical pain
- Recurring dreams in Bash syntax
- Obsession with aesthetically perfect terminal colors

### USAGE INSTRUCTIONS

1. Back up everything. EVERYTHING. Including your childhood memories.
2. Install at your own risk.
3. If your computer starts whispering your name at night, consider a digital exorcism.

### TECHNICAL SUPPORT

Support available between 25h and 27h on Tuesdays that don't exist on the calendar. Alternatively, try screaming into the void and see if it responds.

---

**By proceeding with installation, you acknowledge that you have been duly warned and that any resemblance between these dotfiles and a portal to chaotic dimensions is purely coincidental.**

*P.S.: If your files start self-modifying to improve their own efficiency, please share the code. I'm curious.*
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

