# Ref: https://spaceship-prompt.sh/sections/
# Ref for colors: https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg

# Spaceship settings (fixed syntax)
SPACESHIP_PROMPT_ASYNC=true
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_RPROMPT_ADD_NEWLINE=true

# char
# SPACESHIP_CHAR_SYMBOL="⚡ "
SPACESHIP_CHAR_SYMBOL="$ "
SPACESHIP_CHAR_COLOR_SUCCESS='#a8a8a8'
SPACESHIP_CHAR_COLOR_SECONDARY='#efbf6f'
SPACESHIP_CHAR_COLOR_FAILURE='#870000'

# dir
SPACESHIP_DIR_COLOR='#5f87ff'

# exec_time
SPACESHIP_EXEC_TIME_ELAPSED=10
SPACESHIP_EXEC_TIME_PRECISION=2

# exit_code
SPACESHIP_EXIT_CODE_SHOW=true

# git
SPACESHIP_GIT_ORDER=(git_status git_branch)
SPACESHIP_GIT_COMMIT_SHOW=true
SPACESHIP_GIT_BRANCH_COLOR='#efbf6f'
SPACESHIP_GIT_STATUS_SUFFIX="] "
SPACESHIP_GIT_STATUS_COLOR='#870000'

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

