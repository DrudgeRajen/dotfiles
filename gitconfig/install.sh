#!/bin/bash

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DRY_RUN=false

# Process command line arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    *)
      shift
      ;;
  esac
done

echo "Installing dotfiles from $DOTFILES_DIR"
if [ "$DRY_RUN" = true ]; then
  echo "[DRY RUN] No changes will be made"
fi

# Function to create symlinks or show what would happen
function link_file {
  local src="$1"
  local dest="$2"
  
  if [ "$DRY_RUN" = true ]; then
    if [ -e "$dest" ]; then
      echo "[DRY RUN] Would replace $dest with link to $src"
    else
      echo "[DRY RUN] Would link $src to $dest"
    fi
  else
    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$dest")"
    
    # Create backup if file exists and is not a symlink
    if [ -f "$dest" ] && [ ! -L "$dest" ]; then
      mv "$dest" "$dest.backup.$(date +%Y%m%d%H%M%S)"
      echo "Created backup of existing $dest"
    fi
    
    ln -sf "$src" "$dest"
    echo "Linked $src to $dest"
  fi
}

# Function to link config directories
function link_config_dir {
  local src="$DOTFILES_DIR/.config/$1"
  local dest="$HOME/.config/$1"
  
  if [ -d "$src" ]; then
    if [ "$DRY_RUN" = true ]; then
      echo "[DRY RUN] Would link $src to $dest"
    else
      # Create parent directory if it doesn't exist
      mkdir -p "$(dirname "$dest")"
      
      # Remove existing directory if it's a symlink or create backup if it contains files
      if [ -L "$dest" ]; then
        rm "$dest"
      elif [ -d "$dest" ]; then
        mv "$dest" "$dest.backup.$(date +%Y%m%d%H%M%S)"
        echo "Created backup of existing $dest"
      fi
      
      # Create symlink
      ln -sf "$src" "$dest"
      echo "Linked $src to $dest"
    fi
  fi
}

# Create symbolic links for shell configuration
#echo "Setting up shell configuration..."
#link_file "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"

# Create symbolic links for other configs
echo "Setting up other configurations..."
link_file "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
link_file "$DOTFILES_DIR/git/.gitignore_global" "$HOME/.gitignore_global"

# Set up config directories
echo "Setting up .config directories..."
mkdir -p "$HOME/.config"

# Find all immediate subdirectories in the .config folder
if [ -d "$DOTFILES_DIR/.config" ]; then
  for config_dir in "$DOTFILES_DIR/.config"/*/; do
    if [ -d "$config_dir" ]; then
      dir_name=$(basename "$config_dir")
      link_config_dir "$dir_name"
    fi
  done
fi


# Setup complete
echo "Dotfiles installation complete!"
echo "Note: You may need to restart your terminal for changes to take effect."
