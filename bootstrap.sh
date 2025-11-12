#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for file in "$DOTFILES_DIR"/{.*,*}; do
    [ -e "$file" ] || continue
    basename="$(basename "$file")"
    [ "$basename" = "." ] && continue
    [ "$basename" = ".." ] && continue
    [ "$basename" = ".git" ] && continue
    [ "$basename" = "README.md" ] && continue
    [ -f "$0" ] && [ "$file" -ef "$0" ] && continue
    
    target="$HOME/$basename"
    [ -e "$target" ] || [ -L "$target" ] && continue
    
    ln -s "$file" "$target"
    echo "Linked: $target -> $file"
done
