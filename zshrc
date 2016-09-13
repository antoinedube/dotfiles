export EDITOR="vim"
export TERM="rxvt-unicode-256color"
export BROWSER="chromium"
export HISTCONTROL=ignoreboth

# LS_COLORS=$LS_COLORS:'di=0;37;104';
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

alias l='ls -lh --group-directories-first --color=auto'
alias valgrind='valgrind --leak-check=full --show-reachable=yes --track-origins=yes'
alias grep='grep -n --color=auto'
alias vim='vim -p 2>/dev/null'
alias lock='i3lock'

plugins+=(zsh-completions)
autoload -Uz colors compinit promptinit
colors
compinit
promptinit

setopt extendedGlob
setopt HIST_IGNORE_DUPS
setopt prompt_subst
setopt menu_complete

HISTSIZE=10000
if (( ! EUID )); then
  HISTFILE=~/.history_root
else
  HISTFILE=~/.history
fi
SAVEHIST=10000

bindkey -v
bindkey '^R' history-incremental-search-backward

SEGMENT_SEPARATOR="\ue0b0"
PLUSMINUS="\u00b1"
BRANCH="\ue0a0"
DETACHED="\u27a6"
CROSS="\u2718"
LIGHTNING="\u26a1"
GEAR="\u2699"

CURRENT_BG='NONE'
PRIMARY_FG=black

prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    print -n "%{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%}"
  else
    print -n "%{$bg%}%{$fg%}"
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && print -n $3
}

prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    print -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    print -n "%{%k%}"
  fi
  print -n "%{%f%}"
  CURRENT_BG=''
}

prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}$CROSS"
  [[ -n "$symbols" ]] && prompt_segment NONE default " $symbols "
}

prompt_context() {
  local user=`whoami`
  prompt_segment 237 39 " $user "
}

prompt_dir() {
  prompt_segment 33 235 " %~ "
}

prompt_main() {
  CURRENT_BG='NONE'
  prompt_context
  prompt_dir
  prompt_end
}

prompt_right() {
  RETVAL=$?
  CURRENT_BG='NONE'
  prompt_status
  prompt_git
}

prompt_git() {
  local color ref
  is_dirty() { test -n "$(git status --porcelain --ignore-submodules)" }
  ref="$vcs_info_msg_0_"
  if [[ -n "$ref" ]]; then
    if is_dirty; then
      color=166
    else
      color=green
    fi
    local commit_hash="$( git rev-parse HEAD | cut -c1-6 )"
    prompt_segment 237 $color " $BRANCH  $commit_hash "
    prompt_segment $color 235 " $ref "
    prompt_end
  fi
}

prompt_precmd() {
  vcs_info
  PROMPT='%{%f%b%k%}$(prompt_main) '
  RPROMPT='$(prompt_right)'
}

custom_prompt_setup() {
  autoload -Uz vcs_info add-zsh-hook

  prompt_opts=(cr subst percent)
  add-zsh-hook precmd prompt_precmd

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' check-for-changes false
  zstyle ':vcs_info:git*' formats "%b"
  zstyle ':vcs_info:git*' actionformats "%b (%a)"
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
  zstyle ':completion:*' menu select
  zstyle ':completion:*' rehash true
}

custom_prompt_setup "$@"

export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
[[ -r "$HOME/.rvm/scripts/completion" ]] && source "$HOME/.rvm/scripts/completion"
