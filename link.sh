#!/bin/bash

set -U

DOTPATH=~/.dotfiles

echo "start setup..."

for f in .??*; do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".DS_Store" ] && continue
    [ "$f" = ".gitmodules" ] && continue

    ln -sfv "$DOTPATH"/"$f" "$HOME"/"$f"
done


cat << END

**************************************************
DOTFILES SETUP FINISHED! bye.
**************************************************

END