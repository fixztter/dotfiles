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
alias ll='exa -l'
alias la='exa -a'
alias r='ranger'
alias l='exa -lah'

#PS1='\[\e[0;1;93m\][\[\e[0;1;92m\]\u\[\e[0;1;91m\]@\[\e[0;1;92m\]\H\[\e[0;97m\] \[\e[0;1;94m\]\W\[\e[0;1;93m\]]\[\e[0;38;5;255m\]\$ \[\e[0m\]'
#PS1='\[\e[0;1;92m\]\u\[\e[0;91m\]@\[\e[0;1;92m\]\H\[\e[0;38;5;255m\]:\[\e[0;1;94m\]\W\[\e[0;38;5;254m\]$ \[\e[0m\]'
#PS1="\[\e[33m\][\[\e[m\]\[\e[31m\]\u\[\e[m\]@\[\e[36m\]\h\[\e[m\]:\[\e[35m\]\w\[\e[m\]\[\e[33m\]]\[\e[m\] \$ "
PS1='\[\e[0;1;94m\]\W\[\e[0m\] $ \[\e[0m\]'

PS2='\[\e[0;1;93m\]>\[\e[0;1;95m\]>\[\e[0;1;96m\]> \[\e[0m\]'

export NVM_DIR="$HOME/.nvm"
export TERM="xterm-256color"
export EDITOR=nvim
export PATH
export MANPAGER="sh -c 'col -bx | bat -l man -p'"


[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

