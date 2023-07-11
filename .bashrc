# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ $DISPLAY ]] && shopt -s checkwinsize

export EDITOR="nvim"

export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

alias ls='exa --group-directories-first --icons'
alias ll='exa -lh --group-directories-first --icons'
alias la='exa -ah --group-directories-first --icons'
alias l='exa -lah --group-directories-first --icons'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# alias ls='ls --color=auto --group-directories-first'
# alias ll='ls -lh'
# alias la='ls -ah'
# alias l='ls -lah'

. /usr/share/git/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1

# [username@hostname ~]$
PS1='\[\e[0;1;93m\][\[\e[0;1;92m\]\u\[\e[0;1;91m\]@\[\e[0;1;92m\]\H\[\e[0;97m\] \[\e[0;1;94m\]\W\[\e[0;1;91m\]\[\e[0;1;91m\]$(__git_ps1 "(%s)")\[\e[0;1;93m\]]\[\e[0;1m\]$\[\e[0m\] '

# ~ $
# PS1='\[\e[0;1;94m\]\w\[\e[0;1;91m\]$(__git_ps1 "(%s)")\e[0;1;97m\] $\[\e[0m\] '

# username@hostname ~ $
# PS1='\[\e[0;1;92m\]\u\[\e[0;1;91m\]@\[\e[0;1;92m\]\H\[\e[0;1;94m\] \w\[\e[0;1;94m\]\[\[\e[0;1;95m\]$(__git_ps1 "(%s)") \[\e[0;1;94m\]$\[\e[0m\] ' 

# root
# PS1='\[\e[91;1m\]\u@\H\[\e[94m\] \w #\[\e[0m\] '

# PS1='[\u@\h \W]\$ '
PS2='\[\e[0;1;93m\]>\[\e[0;1;95m\]>\[\e[0;1;96m\]> \[\e[0m\]'

case ${TERM} in
    Eterm*|alacritty*|aterm*|foot*|gnome*|konsole*|kterm*|putty*|rxvt*|tmux*|xterm*|st*)
    PROMPT_COMMAND+=('printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"')
    ;;
  screen*)
    PROMPT_COMMAND+=('printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"')
    ;;
esac

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

# eval "$(starship init bash)"
