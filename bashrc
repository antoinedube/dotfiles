export ESC=$( printf '\033' )

function find_git_branch() {
  # Get git branch modified status
  local status=$( git status --porcelain 2> /dev/null )
  local modified=''
  if [[ "$status" != "" ]]; then
    modified="!!"
  fi

  local branch
  local revision

  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      branch='detached*'
    fi
    revision="$( git rev-parse HEAD | cut -c1-6 )"
    git_branch="[$branch >> $revision  ${ESC}[0;30m${ESC}[43m$modified${ESC}[0m ]"
  else
    git_branch=""
  fi

}

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
