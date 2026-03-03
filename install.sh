#!/bin/sh
set -e

GITHUB_USERNAME="spencermefford"

echo "[CONFIG] GitHub Email and Username"
git config --global user.email "spencermefford@gmail.com"
git config --global user.name "spencermefford"

echo "[INSTALL] Powerline Fonts"
if [ ! -d ~/.oh-my-zsh ]; then
  gh repo clone powerline/fonts ~/.powerline-fonts
  ~/.powerline-fonts/install.sh
fi

echo "[INSTALL] Ohmyzsh"
if [ ! -d ~/.oh-my-zsh ]; then
  git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
fi

echo "[INSTALL] fzf (fuzzy find)"
rm -rf ~/.fzf
gh repo clone junegunn/fzf ~/.fzf -- --depth 1
rm -rf ~/.fzf/.git
~/.fzf/install --all

echo "[INSTALL] Cursor CLI"
curl https://cursor.com/install -fsS | bash

echo "[INSTALL] Chezmoi"
export BINDIR=$HOME/.local/bin
sh -c "$(curl -fsLS chezmoi.io/get)"

echo "[SETUP] Chezmoi"
$BINDIR/chezmoi init $GITHUB_USERNAME

echo "[APPLY] apply dotfiles"
$BINDIR/chezmoi apply
