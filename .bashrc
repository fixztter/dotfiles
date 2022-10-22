# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ $DISPLAY ]] && shopt -s checkwinsize

export EDITOR="nvim"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

alias ls='exa'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias ll='exa -l'
alias la='exa -a'
alias l='exa -la'

. /usr/share/git/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1

# [username@hostname ~]$
PS1='\[\e[0;1;93m\][\[\e[0;1;92m\]\u\[\e[0;1;91m\]@\[\e[0;1;92m\]\H\[\e[0;97m\] \[\e[0;1;94m\]\W\[\e[0;1;91m\]\[\e[0;1;91m\]$(__git_ps1 "(%s)")\[\e[0;1;93m\]]\[\e[0;1m\]$\[\e[0m\] '

# ~ $
# PS1='\[\e[0;1;94m\]\w\[\e[0;1;91m\]$(__git_ps1 "(%s)")\e[0;1;97m\] $\[\e[0m\] '

# username@hostname ~ $
# PS1='\[\e[0;1;92m\]\u\[\e[0;1;91m\]@\[\e[0;1;92m\]\H\[\e[0;1;94m\] \w\[\e[0;1;94m\]\[\[\e[0;1;95m\]$(__git_ps1 "(%s)") \[\e[0;1;94m\]$\[\e[0m\] ' 

# PS1='[\u@\h \W]\$ '
PS2='\[\e[0;1;93m\]>\[\e[0;1;95m\]>\[\e[0;1;96m\]> \[\e[0m\]'

case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*|konsole|alacritty|st)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    ;;
  screen*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    ;;
esac

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

# eval "$(starship init bash)"
