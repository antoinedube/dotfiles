setopt extendedGlob
setopt HIST_IGNORE_DUPS
setopt prompt_subst

export EDITOR="vim"
export TERM="rxvt"
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
autoload -Uz colors compinit promptinit vcs_info
colors
compinit
promptinit

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats "%b  %m  %u  %c  %a "
zstyle ':vcs_info:git*' actionformats "%b  %F{${red}}| %a%f"
precmd () {
  vcs_info
}

SEGMENT_SEPARATOR="\ue0b0"
PLUSMINUS="\u00b1"
BRANCH="\ue0a0"
DETACHED="\u27a6"
CROSS="\u2718"
LIGHTNING="\u26a1"
GEAR="\u2699"

# http://www.nparikh.org/unix/prompt.php
# https://gist.github.com/agnoster/3712874
# https://github.com/bhilburn/powerlevel9k/blob/master/powerlevel9k.zsh-theme

#PS1='%F{blue}%n%{$reset_color%} at %m:%/ %# '
PS1='%F{208}%n%f%F{yellow}@%f%F{blue}%m%f %# '
PS2='> '
# RPROMPT="[%{$fg_no_bold[yellow]%}%?%{$reset_color%}]"
RPROMPT="\$vcs_info_msg_0_"
