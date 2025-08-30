#!/usr/bin/env bash

echo 'Uninstalling jump command...'

# Remove the jump binary
if [[ -f "$HOME/.jump-completion/jump" ]]; then
    rm -f "$HOME/.jump-completion/jump"
    echo 'Removed jump binary'
else
    echo 'Jump binary not found (already removed?)'
fi

# Remove the directory if empty
if [[ -d "$HOME/.jump-completion" ]]; then
    rmdir "$HOME/.jump-completion" 2>/dev/null && echo 'Removed jump-completion directory' || echo 'Jump-completion directory not empty (keeping it)'
fi

# Remove completion files
removed_completion=false

if [[ -f ~/.oh-my-zsh/custom/completions/_jump ]]; then
    rm -f ~/.oh-my-zsh/custom/completions/_jump
    echo 'Removed oh-my-zsh jump completion'
    removed_completion=true
fi

if [[ -f ~/.config/zsh/completions/_jump ]]; then
    rm -f ~/.config/zsh/completions/_jump
    echo 'Removed zsh jump completion'
    removed_completion=true
fi

if [[ "$removed_completion" == false ]]; then
    echo 'No completion files found (already removed?)'
fi

echo ''
echo 'Uninstall complete!'
echo ''
echo 'Manual cleanup needed:'
echo '1. Remove from PATH: export PATH="$HOME/.jump-completion:$PATH"'
echo '2. Remove JUMP_COMP_CONFIG_PATH environment variable'
echo '3. Reload your shell or run: source ~/.zshrc'