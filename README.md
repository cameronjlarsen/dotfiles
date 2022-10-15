# dotfiles

Contains my config files

## Installing

Requires `git` and GNU `stow`

Clone into `$HOME` directory or `~`

```bash
git clone https://github.com/cameronjlarsen/dotfiles ~
```

Run `stow` from `/dotfiles` directory like so:
This will stow the `.config` directory at `$HOME/.config/`

```bash
stow -v -R .config -t ~/.config
```

This will stow the `Wallpapers` directory at `$HOME/Pictures/Wallpapers/`

```bash
stow -v -R Wallpapers -t ~/Pictures/Wallpapers/
```

To stow individual config folders `CD` into `/dotfiles/.config/` 
run `stow` with the desired config folder like so:

```bash
stow -v -R nvim -t ~/.config 
```

The above command will stow only the `nvim` config folder at `$HOME/.config/nvim`
