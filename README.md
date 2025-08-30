# jump-zsh-completion
JSON driven zsh auto completion

## Set up
```zsh
cd jump-zsh-completion
./autocomp-setup.sh
```

This will create a config file at `~/.jump-completion/config.json` that you can customize with your own commands.

## Uninstall
To remove the jump command:
```zsh
./autocomp-uninstall.sh
```

Then manually remove the PATH entry from your `.zshrc`.

