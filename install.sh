#!/bin/bash

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

section() {
    echo -e "\n${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}\n"
}

# Detect OS
OS="$(uname -s)"
info "Detected OS: $OS"

# Check if we're on a supported OS
if [ "$OS" != "Linux" ] && [ "$OS" != "Darwin" ]; then
    error "Unsupported OS: $OS"
    exit 1
fi

# Install Node.js (latest LTS)
install_nodejs() {
    section "Installing Node.js (LTS)"
    
    if [ "$OS" = "Linux" ]; then
        # Check if Node.js is already installed with correct version
        if command -v node &> /dev/null; then
            NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
            if [ "$NODE_VERSION" -ge 20 ]; then
                success "Node.js v$(node -v) already installed"
                return
            else
                warn "Node.js version too old ($(node -v)), upgrading..."
                sudo apt remove -y nodejs npm || true
            fi
        fi
        
        info "Installing Node.js 20 LTS via NodeSource..."
        
        # Install Node.js 20 LTS using NodeSource
        curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
        sudo apt install -y nodejs
        
        success "Node.js $(node -v) and npm $(npm -v) installed"
        
    elif [ "$OS" = "Darwin" ]; then
        if ! command -v node &> /dev/null; then
            warn "Install Node.js via Homebrew: brew install node@20"
        else
            success "Node.js already installed"
        fi
    fi
}

# Install Mason dependencies (Python, Go, etc.)
install_mason_dependencies() {
    section "Installing Mason/LSP Dependencies"
    
    if [ "$OS" = "Linux" ]; then
        info "Installing Python and pip..."
        sudo apt install -y python3 python3-pip python3-venv
        
        info "Installing Go..."
        sudo snap install go --classic
        
        info "Installing other build tools..."
        sudo apt install -y \
            build-essential \
            cmake \
            pkg-config \
            libssl-dev \
            unzip \
            gettext
        
        success "Mason dependencies installed"
        
    elif [ "$OS" = "Darwin" ]; then
        warn "macOS detected - install via Homebrew:"
        warn "  brew install python go cmake"
    fi
}

# Install CLI tools and utilities
install_cli_tools() {
    section "Installing CLI Tools"
    
    if [ "$OS" = "Linux" ]; then
        info "Installing essential CLI tools..."
        sudo apt install -y \
            git \
            curl \
            wget \
            ripgrep \
            fd-find \
            fzf \
            tree \
            htop \
            jq \
            unzip \
            zip
        
        success "CLI tools installed"
        
    elif [ "$OS" = "Darwin" ]; then
        warn "macOS detected - install via Homebrew:"
        warn "  brew install ripgrep fd fzf tree htop jq"
    fi
}

# Install Neovim
install_neovim() {
    section "Installing Neovim"
    
    if [ "$OS" = "Linux" ]; then
        if ! command -v nvim &> /dev/null; then
            info "Installing Neovim via snap..."
            sudo snap install nvim --classic
            success "Neovim installed"
        else
            success "Neovim already installed"
        fi
    elif [ "$OS" = "Darwin" ]; then
        if ! command -v nvim &> /dev/null; then
            warn "Install Neovim via Homebrew: brew install neovim"
        else
            success "Neovim already installed"
        fi
    fi
}

# Install tmux
install_tmux() {
    section "Installing tmux"
    
    if [ "$OS" = "Linux" ]; then
        if ! command -v tmux &> /dev/null; then
            info "Installing tmux..."
            sudo apt install -y tmux
            success "tmux installed"
        else
            success "tmux already installed"
        fi
    elif [ "$OS" = "Darwin" ]; then
        if ! command -v tmux &> /dev/null; then
            warn "Install tmux via Homebrew: brew install tmux"
        else
            success "tmux already installed"
        fi
    fi
}

# Install Rust
install_rust() {
    section "Installing Rust"
    
    if ! command -v rustc &> /dev/null; then
        info "Installing Rust..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        source "$HOME/.cargo/env"
        success "Rust installed"
        info "Added Rust to current shell. For new shells, Rust will be available automatically."
    else
        success "Rust already installed"
    fi
}

# Create necessary directories
create_directories() {
    section "Creating Directories"
    
    info "Creating necessary directories..."
    mkdir -p ~/.config
    mkdir -p ~/.local/share
    mkdir -p ~/.local/state
    mkdir -p ~/.cache
    success "Directories created"
}

# Setup Neovim
setup_neovim() {
    section "Setting up Neovim Config"
    
    # Remove old config if exists
    if [ -L ~/.config/nvim ] || [ -d ~/.config/nvim ]; then
        warn "Removing existing Neovim config..."
        rm -rf ~/.config/nvim
    fi
    
    # Remove old data
    rm -rf ~/.local/share/nvim
    rm -rf ~/.local/state/nvim
    rm -rf ~/.cache/nvim
    
    # Create symlink
    ln -sf ~/dotfiles/.config/nvim ~/.config/nvim
    success "Neovim config linked"
}

# Setup tmux
setup_tmux() {
    section "Setting up tmux Config"
    
    # Remove old config if exists
    if [ -L ~/.tmux.conf ] || [ -f ~/.tmux.conf ]; then
        warn "Removing existing tmux config..."
        rm -f ~/.tmux.conf
    fi
    
    # Create symlink
    ln -sf ~/dotfiles/.config/.tmux.conf ~/.tmux.conf
    success "tmux config linked"
    
    # Install TPM (Tmux Plugin Manager)
    if [ ! -d ~/.tmux/plugins/tpm ]; then
        info "Installing TPM (Tmux Plugin Manager)..."
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
        success "TPM installed"
    else
        success "TPM already installed"
    fi
}

# Print summary
print_summary() {
    section "Installation Summary"
    
    echo "✅ Node.js $(node -v) and npm $(npm -v) installed"
    echo "✅ System dependencies installed (Python, Go, etc.)"
    echo "✅ CLI tools installed (ripgrep, fzf, etc.)"
    echo "✅ Neovim installed and configured"
    echo "✅ tmux installed and configured"
    echo "✅ Rust toolchain installed"
    echo ""
    info "Next steps:"
    echo "  1. Restart your shell or run: source ~/.cargo/env"
    echo "  2. Open nvim - LazyVim will install plugins automatically"
    echo "  3. Mason will install LSPs (rust-analyzer, etc.) automatically"
    echo "  4. Start tmux and press prefix + I to install tmux plugins"
    echo ""
    success "Happy coding! 🚀"
}

# Main installation
main() {
    section "Dotfiles Installation Script"
    
    info "This script will install:"
    echo "  • Node.js 20 LTS & npm"
    echo "  • System dependencies (Python, Go)"
    echo "  • CLI tools (ripgrep, fzf, fd, etc.)"
    echo "  • Neovim & tmux"
    echo "  • Rust toolchain"
    echo "  • Your dotfiles configuration"
    echo ""
    
    # Ask for confirmation
    read -p "Continue with installation? (y/n) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        warn "Installation cancelled"
        exit 0
    fi
    
    # Linux needs sudo, check if available
    if [ "$OS" = "Linux" ]; then
        if ! sudo -v; then
            error "This script requires sudo access"
            exit 1
        fi
    fi
    
    # Run installations
    if [ "$OS" = "Linux" ]; then
        info "Updating package list..."
        sudo apt update
    fi
    
    install_cli_tools
    install_nodejs        # Install Node.js FIRST (with correct version)
    install_mason_dependencies
    install_neovim
    install_tmux
    install_rust
    create_directories
    setup_neovim
    setup_tmux
    
    print_summary
}

# Run main function
main
