plugins+=(zsh-completions)
autoload -Uz compinit promptinit
compinit
promptinit

setopt HIST_IGNORE_DUPS

#prompt walters
. /usr/lib/python3.5/site-packages/powerline/bindings/zsh/powerline.zsh
