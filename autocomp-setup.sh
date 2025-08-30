#!/usr/bin/env bash

# Colors
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
reset=$(tput sgr0)

echo "${blue}Installing jump command...${reset}"
mkdir -p "$HOME/.jump-completion"
install -m755 ./autocomp "$HOME/.jump-completion/jump"
echo "${green}✓ Installed jump binary${reset}"

echo "${blue}Creating default configuration...${reset}"
if [[ ! -f "$HOME/.jump-completion/config.json" ]]; then
    cp ./autocomp.json "$HOME/.jump-completion/config.json"
    echo "${green}✓ Created config file at ~/.jump-completion/config.json${reset}"
else
    echo "${yellow}⚠ Config file already exists (keeping existing)${reset}"
fi

echo "${blue}Setting up auto completions...${reset}"
if [[ -d ~/.oh-my-zsh ]]; then
    mkdir -p ~/.oh-my-zsh/custom/completions
    cp ./jump-autocomp.sh ~/.oh-my-zsh/custom/completions/_jump
    echo "${green}✓ Completion installed to oh-my-zsh${reset}"
else
    mkdir -p ~/.config/zsh/completions
    cp ./jump-autocomp.sh ~/.config/zsh/completions/_jump
    echo "${green}✓ Completion installed to ~/.config/zsh/completions${reset}"
    echo "${yellow}Add this to your .zshrc:${reset}"
    echo "  fpath=(~/.config/zsh/completions \$fpath)"
    echo "  autoload -U compinit && compinit"
fi

echo ""
echo "${green}Installation complete!${reset}"
echo ""
echo "${yellow}Manual step required:${reset}"
echo "1. Add this to your .zshrc:"
echo "  export PATH=\"\$HOME/.jump-completion:\$PATH\""
echo ""
echo "2. Edit ~/.jump-completion/config.json to customize your commands"
echo ""
echo "3. Then reload your shell: ${blue}source ~/.zshrc${reset}"
