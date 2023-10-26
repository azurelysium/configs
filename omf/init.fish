# https://www.gnu.org/software/emacs/manual/html_node/efaq/Colors-on-a-TTY.html
set -xg LD_LIBRARY_PATH /usr/local/lib
set -xg COLORTERM truecolor
set -xg TERM xterm
set -xg EDITOR vim
set -xg POETRY_VIRTUALENVS_IN_PROJECT true
set -xg DOCKER_BUILDKIT 1

# PATH settings
set -xg PATH $PATH /snap/bin /opt/homebrew/bin
set -U fish_user_paths $fish_user_paths $HOME/Bin $HOME/.local/bin $HOME/go/bin

alias 'emacs'='emacs -nw'
alias 'k'='kubectl'
alias 'kx'='kubectx'
alias 'kn'='kubens'
alias 'kk'='echo Context: (kubectx -c) \nNamespace: (kubens -c)'
alias 'nvim'='TERM=st SHELL=sh /usr/bin/env nvim'

# Pyenv
set -xg PYENV_ROOT $HOME/.pyenv
set -xg PATH "$PATH:$PYENV_ROOT/bin"
if command -v pyenv 1>/dev/null 2>&1
  pyenv init - | source
end

set -xg VIRTUAL_ENV_DISABLE_PROMPT 1
. ~/envs/default/bin/activate.fish

# Direnv
if command -v direnv 1>/dev/null 2>&1
  direnv hook fish | source
end

# NVM
set -xg NVM_DIR $HOME/.nvm
function nvm
  bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end

# Rustup
bass source ~/.cargo/env
