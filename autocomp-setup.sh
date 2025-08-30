#!/usr/bin/env bash

echo 'Installing jump command'
mkdir -p "$HOME/.jump-completion"
install -m755 ./autocomp "$HOME/.jump-completion/jump"

echo 'Setting up auto completions for jump command'
if [[ -d ~/.oh-my-zsh ]]; then
    mkdir -p ~/.oh-my-zsh/custom/completions
    cp ./jump-autocomp.sh ~/.oh-my-zsh/custom/completions/_jump
    echo 'Completion installed to oh-my-zsh custom completions'
else
    mkdir -p ~/.config/zsh/completions
    cp ./jump-autocomp.sh ~/.config/zsh/completions/_jump
    echo 'Completion installed to ~/.config/zsh/completions'
    echo 'Add this to your .zshrc:'
    echo 'fpath=(~/.config/zsh/completions $fpath)'
    echo 'autoload -U compinit && compinit'
fi

echo 'Please add the following line to your PATH var'
echo 'export PATH="$HOME/.jump-completion:$PATH"'
echo 'Then you are ready to use the jump command!'
