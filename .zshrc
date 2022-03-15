autoload -Uz compinit
compinit
autoload -U colors && colors
bindkey -v
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select
zstyle ':completion:*:descriptions' format '%U%F{magenta}%d%f%u'

# PROMPT="%B%{$fg[green]%}%n%{$fg[red]%}@%{$fg[green]%}%M %{$fg[blue]%}%~ %{$reset_color%}%B%F{blue}$%f%b "
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

alias ls='exa'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias ll='exa -lh'
alias la='exa -a'
alias r='ranger'
alias l='exa -lah'

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^A" beginning-of-line
bindkey "^D" delete-char-or-list
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^O" accept-line

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

# ~/.zshrc

eval "$(starship init zsh)"
