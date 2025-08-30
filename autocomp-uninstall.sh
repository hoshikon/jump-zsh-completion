#!/usr/bin/env bash

# Colors
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
reset=$(tput sgr0)

echo "${blue}Uninstalling jump command...${reset}"

# Remove the jump binary
if [[ -f "$HOME/.jump-completion/jump" ]]; then
    rm -f "$HOME/.jump-completion/jump"
    echo "${green}✓ Removed jump binary${reset}"
else
    echo "${yellow}⚠ Jump binary not found (already removed?)${reset}"
fi

# Remove the directory if empty
if [[ -d "$HOME/.jump-completion" ]]; then
    rmdir "$HOME/.jump-completion" 2>/dev/null && echo "${green}✓ Removed jump-completion directory${reset}" || true
fi

# Remove completion files
removed_completion=false

if [[ -f ~/.oh-my-zsh/custom/completions/_jump ]]; then
    rm -f ~/.oh-my-zsh/custom/completions/_jump
    echo "${green}✓ Removed oh-my-zsh completion${reset}"
    removed_completion=true
fi

if [[ -f ~/.config/zsh/completions/_jump ]]; then
    rm -f ~/.config/zsh/completions/_jump
    echo "${green}✓ Removed zsh completion${reset}"
    removed_completion=true
fi

if [[ "$removed_completion" == false ]]; then
    echo "${yellow}⚠ No completion files found (already removed?)${reset}"
fi

# Optionally remove config file
if [[ -f "$HOME/.jump-completion/config.json" ]]; then
    echo ""
    echo "${yellow}Config file found at ~/.jump-completion/config.json${reset}"
    echo "You may want to delete it if you no longer need your jump commands:"
    echo "  ${blue}rm ~/.jump-completion/config.json${reset}"
fi

echo ""
echo "${green}✓ Uninstall complete!${reset}"
echo ""
echo "${yellow}Manual cleanup needed:${reset}"
echo "1. Remove from PATH: ${blue}export PATH=\"\$HOME/.jump-completion:\$PATH\"${reset}"
echo "2. Reload your shell: ${blue}source ~/.zshrc${reset}"