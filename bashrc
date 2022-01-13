export ESC=$( printf '\033' )

[ -z "$PS1" ] && return

export EDITOR="vim"
export TERM="rxvt"
export BROWSER="chromium"

SEGMENT_SEPARATOR="\ue0b0"
PLUSMINUS="\u00b1"
BRANCH="\ue0a0"
DETACHED="\u27a6"
LIGHTNING="\u26a1"
GEAR="\u2699"

export HISTCONTROL=ignoreboth
LS_COLORS=$LS_COLORS:'di=0;37;104' ; export LS_COLORS

alias l='ls -lh --group-directories-first --color=auto'
alias valgrind='valgrind --leak-check=full --show-reachable=yes --track-origins=yes'
alias aria-bt='aria2c --bt-min-crypto-level=arc4 --bt-require-crypto=true'
alias grep='grep -n --color=auto'
alias qemu64='qemu-system-x86_64 -enable-kvm'
# alias vim='nvim -p'
alias lock='i3lock'


function find_git_branch() {
  # Get git branch modified status
  local status=$( git status --porcelain 2> /dev/null )
  local modified=''
  if [[ "$status" != "" ]]; then
    modified=" !!"
  fi

  local branch
  local revision

  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      branch='detached*'
    fi
    revision="$( git rev-parse HEAD | cut -c1-6 )"
    opening_bracket="${ESC}[38;5;237m[${ESC}[0m"
    colored_branch="${ESC}[38;5;214m$branch${ESC}[0m"
    middle_symbol="${ESC}[38;5;237m>>${ESC}[0m"
    colored_revision="${ESC}[38;5;245m$revision${ESC}[0m"
    modif_symbol="${ESC}[38;5;202m$modified${ESC}[0m"
    closing_bracket="${ESC}[38;5;237m]${ESC}[0m"
    git_branch="${opening_bracket}${colored_branch} ${middle_symbol} ${colored_revision}${modif_symbol}${closing_bracket} "
  else
    git_branch=""
  fi

}

shopt -s autocd
shopt -s checkwinsize
shopt -s globstar

cd ~

PROMPT_COMMAND="find_git_branch;"
PS1='\[${ESC}[38;5;34m\]\u\[${ESC}[0m\]\[${ESC}[38;5;22m\]@\[${ESC}[0m\]\[${ESC}[38;5;34m\]\h\[${ESC}[0m\]\[${ESC}[38;5;27m\] \w \[${ESC}[0m\]\[$git_branch\]\n\[${ESC}[0m\]\[${ESC}[38;5;10m\]==> \[${ESC}[0m\]'

export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
[[ -r "$HOME/.rvm/scripts/completion" ]] && source "$HOME/.rvm/scripts/completion"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

