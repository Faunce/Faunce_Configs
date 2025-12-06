#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(pwd)"

echo "Bootstrapping dotfiles from $DOTFILES_DIR..."

# Function to safely symlink files
symlink_file() {
    local src="$1"
    local dest="$2"

    if [ -e "$dest" ]; then
        echo "Skipping $dest (already exists)"
    else
        ln -s "$src" "$dest"
        echo "Linked $dest -> $src"
    fi
}

# Top-level dotfiles (skip . and .. and .config and bootstrap.sh itself)
for file in "$DOTFILES_DIR"/.*; do
    base="$(basename "$file")"
    [[ "$base" == "." || "$base" == ".." || "$base" == ".config" || "$base" == "bootstrap.sh" || "$base" == ".git" ]] && continue
    symlink_file "$file" "$HOME/$base"
done

# Files inside .config
if [ -d "$DOTFILES_DIR/.config" ]; then
    mkdir -p "$HOME/.config"
    for cfg in "$DOTFILES_DIR/.config/"*; do
        dest="$HOME/.config/$(basename "$cfg")"
        symlink_file "$cfg" "$dest"
    done
fi

echo "Dotfiles bootstrapped."

