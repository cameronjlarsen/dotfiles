#!/bin/sh
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"
export ZDOTDIR=$HOME/.config/zsh
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
# Immediately append to history file:
setopt INC_APPEND_HISTORY
# Record timestamp in history:
setopt EXTENDED_HISTORY
# Expire duplicate entries first when trimming history:
setopt HIST_EXPIRE_DUPS_FIRST
# Dont record an entry that was just recorded again:
setopt HIST_IGNORE_DUPS
# Delete old recorded entry if new entry is a duplicate:
setopt HIST_IGNORE_ALL_DUPS
# Do not display a line previously found:
setopt HIST_FIND_NO_DUPS
# Dont record an entry starting with a space:
setopt HIST_IGNORE_SPACE
# Dont write duplicate entries in the history file:
setopt HIST_SAVE_NO_DUPS
# Share history between all sessions:
setopt SHARE_HISTORY
# Execute commands using history (e.g.: using !$) immediatel:
unsetopt HIST_VERIFY

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
# zsh_add_completion "esc/conda-zsh-completion" false
# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
# More completions https://github.com/zsh-users/zsh-completions

# Aliases
plug "$ZDOTDIR/aliases.zsh"
plug "$ZDOTDIR/functions.zsh"

# Key-bindings
bindkey '^ ' autosuggest-accept

zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:ls:*' fzf-preview 'ls --color $realpath'

eval "$(op completion zsh)"; compdef _op op

# tabtab source for pnpm package
# uninstall by removing these lines
[[ -f "$HOME/.config/tabtab/zsh/__tabtab.zsh" ]] && . "$HOME/.config/tabtab/zsh/__tabtab.zsh" || true

# Wezterm shell integration
[[ -f "$HOME/.config/wezterm/wezterm.sh" ]] && source "$HOME/.config/wezterm/wezterm.sh"

[[ -f "$HOME/.conifg/op/plugins.sh" ]] && source "$HOME/.config/op/plugins.sh"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

eval "$(fnm env --use-on-cd --shell zsh)"

# Starship prompt
eval "$(starship init zsh)"

# pnpm
export PNPM_HOME="/home/camjl/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
