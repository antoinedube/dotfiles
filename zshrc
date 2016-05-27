plugins+=(zsh-completions)
autoload -Uz compinit promptinit
compinit
promptinit

setopt HIST_IGNORE_DUPS

prompt walters
