# dotfiles

Contains my config files

# Installing

Requires `git` and GNU `stow`

Clone into `$HOME` directory or `~`

```
git clone https://github.com/cameronjlarsen/dotfiles ~
```

Run `stow` to symlink everything or selected items

```
stow */ # Everything (the '/' ignores the README 
```

```
stow nvim # Just nvim config
```
