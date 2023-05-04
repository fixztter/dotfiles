autoload -Uz compinit
compinit
autoload -U colors && colors
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select
zstyle ':completion:*:descriptions' format '%U%F{magenta}%d%f%u'

PROMPT="%B%{$fg[green]%}%n%{$fg[red]%}@%{$fg[green]%}%M %{$fg[blue]%}%~ %{$reset_color%}%B%F{blue}$%f%b "

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

alias ls='exa --group-directories-first --icons'
alias ll='exa -lh --group-directories-first --icons'
alias la='exa -a --group-directories-first --icons'
alias l='exa -lah --group-directories-first --icons'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias r='ranger'

WORDCHARS=${WORDCHARS//\/}
bindkey -v
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[H" beginning-of-line
bindkey "^D" delete-char-or-list
bindkey "^[[F" end-of-line
bindkey "^K" kill-line
bindkey "^O" accept-line

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

# neofetch

# eval "$(starship init zsh)"
