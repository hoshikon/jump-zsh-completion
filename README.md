# jump-zsh-completion
JSON driven oh-my-zsh auto completion

## Set up
Set env var `JUMP_COMP_CONFIG_PATH` to where the config file is.

Then run:
```zsh
cd jump-zsh-completion
./autocomp-setup.sh
```

## Uninstall
To remove the jump command:
```zsh
./autocomp-uninstall.sh
```

Then manually remove the environment variables from your `.zshrc`.

