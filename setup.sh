#!/bin/bash

# Dotfiles setup script
# Run this on a new machine to set up symlinks

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting up dotfiles from $DOTFILES_DIR"

# Create symlink for cursorrules
if [ -f "$HOME/.cursorrules" ]; then
    echo "Backing up existing ~/.cursorrules to ~/.cursorrules.backup"
    mv "$HOME/.cursorrules" "$HOME/.cursorrules.backup"
fi

ln -sf "$DOTFILES_DIR/cursorrules" "$HOME/.cursorrules"
echo "Created symlink: ~/.cursorrules -> $DOTFILES_DIR/cursorrules"

echo "Done! Your Cursor rules are now active."
