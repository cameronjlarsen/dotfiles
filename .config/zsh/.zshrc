#!/bin/sh
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"
export ZDOTDIR=$HOME/.config/zsh
HISTFILE=~/.zsh_history

# Add catppuccin-zsh-syntax-highlighting
if [ -e "$ZDOTDIR/plugins/zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh" ]; then
    plug "$ZDOTDIR/plugins/zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh"
fi

# Exports
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
plug "wintermi/zsh-brew"
plug "wintermi/zsh-fnm"
plug "memark/zsh-dotnet-completion"
# zsh_add_completion "esc/conda-zsh-completion" false
# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
# More completions https://github.com/zsh-users/zsh-completions

# Aliases
plug "$ZDOTDIR/aliases.zsh"

# Key-bindings
bindkey '^ ' autosuggest-accept

if command -v bat &> /dev/null; then
    alias cat="bat -pp --theme \"Catppuccin-mocha\""
    alias catt="bat --theme \"Catppuccin-mocha\""
fi

# Wezterm shell integration
[ -f "$HOME/.config/wezterm/wezterm.sh" ] && source "$HOME/.config/wezterm/wezterm.sh"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
# Starship prompt
eval "$(starship init zsh)"
