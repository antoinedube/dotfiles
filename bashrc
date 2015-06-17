[ -z "$PS1" ] && return

export EDITOR="vim"

alias l='ls -lh --group-directories-first --color=auto'
alias valgrind='valgrind --leak-check=full --show-reachable=yes --track-origins=yes'
alias aria-bt='aria2c --bt-min-crypto-level=arc4 --bt-require-crypto=true'
alias grep='grep -ni --color=auto'
alias qemu64='qemu-system-x86_64 -enable-kvm'
alias vim='vim -p'

source ~/.git-completion.bash

cd ~


PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[0;97m\]'

[[ "$PS1" ]]


export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

[[ -r "$HOME/.rvm/scripts/completion" ]] && source "$HOME/.rvm/scripts/completion"
