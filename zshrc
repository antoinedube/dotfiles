export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export HISTCONTROL=ignoreboth
export _JAVA_AWT_WM_NONREPARENTING=1
export QT_QPA_PLATFORMTHEME="qt5ct"

# https://github.com/pypa/pip/issues/7883
export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring
export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

# LS_COLORS=$LS_COLORS:'di=0;37;104';
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

alias l='ls -lh --group-directories-first --color=auto'
alias grep='grep --color=auto'
alias lock='i3lock'
alias vim='vim -p'
alias nvim='nvim -p'
alias activate='source venv/bin/activate'
alias cargo='nice -n 19 cargo'

# bindkey '^[[1;5C' forward-word
# bindkey '^[[1;5D' backward-word

plugins+=(zsh-completions)
autoload -Uz colors compinit promptinit
colors
compinit
promptinit

setopt extendedGlob
setopt HIST_IGNORE_DUPS
setopt prompt_subst
setopt menu_complete
setopt RM_STAR_WAIT
setopt CORRECT
setopt COMPLETE_ALIASES

HISTSIZE=10000
if (( ! EUID )); then
  HISTFILE=~/.history_root
else
  HISTFILE=~/.history
fi
SAVEHIST=10000

SEGMENT_SEPARATOR="\ue0b0"
PLUSMINUS="\u00b1"
BRANCH="\ue0a0"
DETACHED="\u27a6"
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
  [[ -n "$symbols" ]] && prompt_segment NONE default " $symbols"
}

prompt_virtualenv() {
    if [ -n "$VIRTUAL_ENV" ]; then
        prompt_segment 33 235 " [venv] "
    fi
}

prompt_context() {
  local user=`whoami`
  local hostname=`hostname`
  prompt_segment 237 33 " $user"
  prompt_segment 237 245 "@"
  prompt_segment 237 33 "$hostname "
}

prompt_dir() {
  prompt_segment 33 235 " %~ "
}

prompt_main() {
  CURRENT_BG='NONE'
  prompt_virtualenv
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
      color=70
    fi
    local commit_hash="$( git rev-parse HEAD | cut -c1-6 )"
    prompt_segment 237 $color " $commit_hash "
    prompt_segment $color 235 " $ref "
    # prompt_end
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

export NVM_DIR="/usr/share/nvm"
export NVM_SOURCE="/usr/share/nvm"
[ -s "$NVM_SOURCE/nvm.sh" ] && . "$NVM_SOURCE/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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

source /usr/share/doc/mcfly/mcfly.zsh
export MCFLY_LIGHT=true
export MCFLY_KEY_SCHEME=vim
export MCFLY_FUZZY=2
export MCFLY_RESULTS_SORT=LAST_RUN
export MCFLY_DISABLE_MENU=TRUE
export MCFLY_INTERFACE_VIEW=TOP
export MCFLY_RESULTS=10

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
