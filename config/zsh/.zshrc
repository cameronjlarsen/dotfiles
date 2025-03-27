#!/bin/sh
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"
export ZAP_GIT_PREFIX="git@github.com:"


# Starship prompt
eval "$(starship init zsh)"

# Add catppuccin-zsh-syntax-highlighting
if [ -e "$ZDOTDIR/plugins/zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh" ]; then
    plug "$ZDOTDIR/plugins/zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh"
  else 
    git clone https://github.com/catppuccin/zsh-syntax-highlighting.git "$ZDOTDIR/plugins/zsh-syntax-highlighting"
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
plug "conda-incubator/conda-zsh-completion"
plug "Aloxaf/fzf-tab"
plug "Freed-Wu/fzf-tab-source"
plug "GianniBYoung/omz-take"

# Aliases
plug "$ZDOTDIR/aliases.zsh"
plug "$ZDOTDIR/functions.zsh"

# Key-bindings
bindkey '^ ' autosuggest-accept

zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:ls:*' fzf-preview 'ls --color $realpath'

eval "$(op completion zsh)"; compdef _op op
