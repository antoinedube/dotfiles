export EDITOR="nvim"
export DIFFPROG="nvim -d"
export TERMINAL="alacritty"
export TERM="alacritty"
export BROWSER="firefox"
export HISTCONTROL=ignoreboth
export _JAVA_AWT_WM_NONREPARENTING=1
export QT_QPA_PLATFORMTHEME="qt5ct"
export PYDEVD_DISABLE_FILE_VALIDATION=1

# https://github.com/pypa/pip/issues/7883
export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring
export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

export HISTTIMEFORMAT="%d/%m/%y %T "

# LS_COLORS=$LS_COLORS:'di=0;37;104';
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

alias l='ls -lh --color=auto'
alias grep='grep --color=auto'
alias lock='i3lock'
alias vim='vim -p'
alias nvim='nvim -p'
alias activate='source venv/bin/activate'
alias cargo='nice -n 19 cargo'
alias ssh='TERM=xterm ssh'
# https://www.reddit.com/r/archlinux/comments/1fykml6/some_aliases_ive_found_to_be_useful_for_arch/
alias ipv4="ip addr show | grep 'inet ' | grep -v '127.0.0.1' | cut -d' ' -f6 | cut -d/ -f1"
alias ipv6="ip addr show | grep 'inet6 ' | cut -d ' ' -f6 | sed -n '2p'"
alias autorem='orphans=$(pacman -Qdtq); [ -z "$orphans" ] && echo "There are no orphaned packages" || sudo pacman -Rsc $orphans'
alias hmmm='sudo pacman -Sy &> /dev/null && sudo pacman -Qu'
alias meteo='curl wttr.in/quebec | head -n -1'
alias error-last-boot='journalctl -b -p err'
alias pkglist='pacman -Qs --color=always | less -R'
alias pacman-fzf-remote="pacman -Slq | fzf --preview 'pacman -Si {}' --layout=reverse"
alias yeet='sudo pacman -Rns'


bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

plugins+=(zsh-completions zsh-history-substring-searc)
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

# Ref: https://i.imgur.com/okBgrw4.png
BLUE=33
GRAY=241
LIGHT_GRAY=246
GREEN=70
ORANGE=214
RED=166

# Ref: man zshmisc
prompt_end() {
    if [ $RET_VAL -eq 0 ]; then
      color=$LIGHT_GRAY
    else
      color=$RED
    fi

    symbol='$'
    print -n " %F{$color}$symbol%f"
}

prompt_virtualenv() {
    if [ -n "$VIRTUAL_ENV" ]; then
        print -n "%F{$ORANGE} [venv]%f"
    fi
}

prompt_context() {
    local user=`whoami`
    print -n "%F{$BLUE} $user %f"
}

prompt_dir() {
    print -n "%F{$GRAY}[%~%F{$GRAY}]%f"
}

prompt_left() {
  prompt_virtualenv
  prompt_context
  prompt_dir
  prompt_end
}

prompt_git() {
    is_dirty() { test -n "$(git status --porcelain --ignore-submodules)" }
    ref="$vcs_info_msg_0_"
    if [[ -n "$ref" ]]; then
        if is_dirty; then
          color=$RED
        else
          color=$GREEN
        fi

        print -n "%F{$color}$ref%f"
    fi
}

prompt_right() {
  prompt_git
}

prompt_precmd() {
    RET_VAL=$?
    vcs_info
    PROMPT='%{%f%b%k%}$(prompt_left) '
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

source /usr/share/nvm/init-nvm.sh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
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

# fzf history search
source <(fzf --zsh)

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# source /usr/bin/aws_zsh_completer.sh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey '^ ' autosuggest-accept
