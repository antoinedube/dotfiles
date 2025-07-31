# Ref: https://spaceship-prompt.sh/sections/

# Spaceship settings (fixed syntax)
SPACESHIP_PROMPT_ASYNC=true
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_RPROMPT_ADD_NEWLINE=true
SPACESHIP_CHAR_SYMBOL="⚡ "

# exec_time
SPACESHIP_EXEC_TIME_ELAPSED=10
SPACESHIP_EXEC_TIME_PRECISION=2

# exit_code
SPACESHIP_EXIT_CODE_SHOW=true

# git
SPACESHIP_GIT_ORDER=(git_status git_branch)
SPACESHIP_GIT_COMMIT_SHOW=true
SPACESHIP_GIT_STATUS_SUFFIX="] "

# Minimal spaceship sections for performance
SPACESHIP_PROMPT_ORDER=(
  dir
  aws
  venv
  exec_time
  jobs
  exit_code
  sudo
  char
)

SPACESHIP_RPROMPT_ORDER=(
  git
)

