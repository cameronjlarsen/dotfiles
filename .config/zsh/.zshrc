#!/bin/sh
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"
export ZDOTDIR=$HOME/.config/zsh
HISTFILE=~/.zsh_history

# Add catppuccin-zsh-syntax-highlighting
if [ -e "$ZDOTDIR/plugins/zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh" ]; then
    plug "$ZDOTDIR/plugins/zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh"
fi

# Normal files to source
plug "$ZDOTDIR/aliases.zsh"
plug "$ZDOTDIR/exports.zsh"

# Plugins
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-completions"
plug "hlissner/zsh-autopair"
plug "zap-zsh/supercharge"
plug "zap-zsh/vim"
plug "zap-zsh/fzf"
plug "zap-zsh/completions"
plug "gradle/gradle-completion"
# zsh_add_completion "esc/conda-zsh-completion" false
# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
# More completions https://github.com/zsh-users/zsh-completions

# Key-bindings
bindkey '^ ' autosuggest-accept

if command -v bat &> /dev/null; then
    alias cat="bat -pp --theme \"Catppuccin-mocha\""
    alias catt="bat --theme \"Catppuccin-mocha\""
fi
# Starship prompt
eval "$(starship init zsh)"
