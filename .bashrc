# pfetch
# neofetch
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='exa'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias ll='exa -lh'
alias la='exa -a'
alias r='ranger'
alias l='exa -lah'

source /usr/share/git/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
#PS1='\[\033[01;34m\]\W\[\e[0;1;91m\]$(__git_ps1 "(%s)")\[\033[37m\] \$\[\033[00m\] '
PS1='\[\e[0;1;93m\][\[\e[0;1;92m\]\u\[\e[0;1;91m\]@\[\e[0;1;92m\]\H\[\e[0;97m\] \[\e[0;1;94m\]\W\[\e[0;1;91m\]\[\e[0;1;91m\]$(__git_ps1 "(%s)")\[\e[0;1;93m\]]\[\e[0;1;97m\]$\[\e[0m\] '
#PS1='\[\e[0;1;92m\]\u\[\e[0;91m\]@\[\e[0;1;92m\]\H\[\e[0;38;5;255m\]:\[\e[0;1;94m\]\W\[\e[0;38;5;254m\]$ \[\e[0m\]'
#PS1="\[\e[33m\][\[\e[m\]\[\e[31m\]\u\[\e[m\]@\[\e[36m\]\h\[\e[m\]:\[\e[35m\]\w\[\e[m\]\[\e[33m\]]\[\e[m\] \$ "

PS2='\[\e[0;1;93m\]>\[\e[0;1;95m\]>\[\e[0;1;96m\]> \[\e[0m\]'

export NVM_DIR="$HOME/.nvm"
export TERM="xterm-256color"
export EDITOR=nvim
export PATH
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[[ $DISPLAY ]] && shopt -s checkwinsize

case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*|konsole|alacritty|st)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    ;;
  screen*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    ;;
esac

use_color=true

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

# eval "$(starship init bash)"

