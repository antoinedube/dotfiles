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

# Aliases
alias l='ls -lh --color=auto'
alias grep='grep --color=auto'
alias lock='i3lock'
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

# Key mapping
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# zsh options
setopt extendedGlob
setopt HIST_IGNORE_DUPS
setopt prompt_subst
setopt menu_complete
setopt RM_STAR_WAIT
setopt CORRECT
setopt COMPLETE_ALIASES

# history configuration
HISTSIZE=10000
if (( ! EUID )); then
  HISTFILE=~/.history_root
else
  HISTFILE=~/.history
fi
SAVEHIST=10000

# plugins
plugins+=(zsh-completions zsh-history-substring-search zsh-autosuggestions zsh-syntax-highlighting)
autoload -Uz colors compinit
colors

if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
    compinit
else
    compinit -C
fi

# Load spaceship
source /usr/lib/spaceship-prompt/spaceship.zsh

# nvm
source /usr/share/nvm/init-nvm.sh

# fzf history search
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_DEFAULT_OPTS="--layout=reverse --inline-info"

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# zsh autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#663399,standout"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
ZSH_AUTOSUGGEST_USE_ASYNC=1

# Load zsh plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

bindkey '^ ' autosuggest-accept
