#!/bin/sh
alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"
alias zshrc='$EDITOR $ZDOTDIR/.zshrc'
alias nvimrc='$EDITOR $HOME/.config/nvim/init.lua'
alias awesomerc='$EDITOR $HOME/.config/awesome/rc.lua'
alias dots='cd $HOME/repos/dotfiles'
alias sudo='sudo -v; sudo '
alias fzfp='fzf --preview "bat --style=numbers --color=always --line-range :500 {}" \
    --preview-window=right:50%:wrap \
    --bind "ctrl-/:change-preview-window(70%|hidden|)"'

#Colorize ls output
alias ls='ls --color=auto'
alias ll='ls -lv --group-directories-first'
alias la='ll -AF'
alias lah='la -h'

#Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
