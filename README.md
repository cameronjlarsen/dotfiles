# dotfiles

Contains my config files

## Installing

Requires `git` and GNU `stow`

Clone into `$HOME` directory or `~`

```
git clone https://github.com/cameronjlarsen/dotfiles ~
```

Run `stow` from `/dotfiles` directory like so:
This will stow the `.config` directory at `$HOME/.config/`

```
stow -v -R .config -t ~/.config
```

This will stow the `Wallpapers` directory at `$HOME/Pictures/Wallpapers/`

```
stow -v -R Wallpapers -t ~/Pictures/Wallpapers/
```

To stow individual config folders `CD` into `/dotfiles/.config/` 
run `stow` with the desired config folder like so:

```
stow -v -R nvim -t ~/.config 
```

The above command will stow only the `nvim` config folder at `$HOME/.config/nvim`
