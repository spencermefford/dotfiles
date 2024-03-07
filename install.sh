#!/bin/sh
set -e

GITHUB_USERNAME="spencermefford"

echo "[CONFIG] GitHub Email and Username"
git config --global user.email "spencermefford@meta.com"
git config --global user.name "spencermefford"

echo "[INSTALL] Ohmyzsh"
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

echo "[INSTALL] fzf (fuzzy find)"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

echo "[INSTALL] Chezmoi"
export BINDIR=$HOME/.local/bin
sh -c "$(curl -fsLS chezmoi.io/get)"

echo "[SETUP] Chezmoi"
$BINDIR/chezmoi init $GITHUB_USERNAME

echo "[APPLY] apply dotfiles"
$BINDIR/chezmoi apply