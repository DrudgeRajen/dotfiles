# 🏠 Dotfiles

Personal configuration files for macOS development environment.

## 📦 What's Included

This repository contains configuration files for:

### 🖥️ Window Management & Desktop
- **AeroSpace** - Tiling window manager for macOS
- **SketchyBar** - Custom menu bar replacement
- **Borders** - Window border styling

### 🔧 Development Tools
- **Neovim** - Text editor configuration
- **Git** - Version control settings
- **Tmux** - Terminal multiplexer with vim navigation
- **Zsh** - Shell configuration with Oh My Zsh

### 🖨️ Terminal & UI
- **Ghostty** - Terminal emulator
- **Starship** - Cross-shell prompt
- **Neofetch** - System information display
- **GitUI** - Git TUI client
- **htop** - Process viewer

### 🚀 Productivity
- **Raycast** - Spotlight replacement
- **Cheat** - Command-line cheat sheets

## 🛠️ Installation

### Prerequisites

- macOS
- [Homebrew](https://brew.sh/) package manager
- [Oh My Zsh](https://ohmyz.sh/) shell framework

### Quick Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. **Install required tools via Homebrew:**
   ```bash
   # Window management
   brew install --cask aerospace
   brew tap FelixKratz/formulae
   brew install sketchybar borders

   # Development tools
   brew install neovim tmux git
   brew install --cask ghostty

   # Terminal tools
   brew install starship neofetch gitui htop cheat

   # Productivity
   brew install --cask raycast
   ```

3. **Create symbolic links:**
   ```bash
   # Zsh configuration
   ln -sf ~/.dotfiles/zsh/.zshrc ~/.zshrc

   # Git configuration
   ln -sf ~/.dotfiles/git/.gitconfig ~/.gitconfig
   ln -sf ~/.dotfiles/git/.gitignore ~/.gitignore_global

   # Application configs
   ln -sf ~/.dotfiles/.config ~/.config

   # Tmux configuration
   ln -sf ~/.dotfiles/.config/.tmux.conf ~/.tmux.conf
   ```

4. **Reload your shell:**
   ```bash
   source ~/.zshrc
   ```

## 📁 Structure

```
.
├── .config/
│   ├── aerospace/          # AeroSpace window manager config
│   ├── borders/            # Window borders styling
│   ├── cheat/              # Cheat sheets
│   ├── gitui/              # Git TUI configuration
│   ├── htop/               # Process viewer config
│   ├── neofetch/           # System info display config
│   ├── nvim/               # Neovim configuration
│   ├── raycast/            # Raycast settings
│   ├── sketchybar/         # Menu bar configuration
│   ├── ghostty/            # Terminal emulator config
│   ├── .tmux.conf          # Tmux configuration
│   └── starship.toml       # Shell prompt config
├── git/
│   ├── .gitconfig          # Git global configuration
│   └── .gitignore          # Global gitignore rules
├── zsh/
│   └── .zshrc              # Zsh shell configuration
└── README.md
```

## 🎛️ Key Features

### Window Management
- **AeroSpace**: Automatic tiling with custom workspace assignments
- **SketchyBar**: Minimal, customizable menu bar
- **Borders**: Visual window borders for better focus

### Development Environment
- **Neovim**: Fully configured with LSP, plugins, and keybindings
- **Tmux**: Session management with vim-style navigation
- **Git**: Optimized settings with useful aliases

### Terminal Experience
- **Zsh + Oh My Zsh**: Enhanced shell with plugins and themes
- **Starship**: Fast, customizable prompt
- **Ghostty**: Fast, native GPU-accelerated terminal

## 🔧 Customization

### Modifying Configurations

Each tool's configuration can be found in its respective directory under `.config/`. Key files to customize:

- **Shell prompt**: `.config/starship.toml`
- **Window management**: `.config/aerospace/aerospace.toml`
- **Editor**: `.config/nvim/`
- **Terminal**: `.config/ghostty/config`
- **Git settings**: `git/.gitconfig`

### Adding New Tools

1. Add configuration files to the appropriate directory under `.config/`
2. Update the installation instructions in this README
3. Add symbolic links in the setup process

## 🤝 Contributing

Feel free to fork this repository and adapt it to your needs. If you find improvements or fixes, pull requests are welcome!

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

**Note**: These dotfiles are tailored for macOS development. Some configurations may need adjustment for other operating systems.
