set -U EDITOR vim
set -U TERM xterm

alias 'emacs'='emacs -nw'
alias 'k'='kubectl'
alias 'kx'='kubectx'
alias 'kn'='kubens'
alias 'kk'='echo Context: (kubectx -c) \nNamespace: (kubens -c)'

# PATH settings
set --export PATH "$PATH:~/Bin:/snap/bin:~/.local/bin"

# Pyenv
set --export PYENV_ROOT $HOME/.pyenv
set --export PATH "$PATH:$PYENV_ROOT/bin"
if command -v pyenv 1>/dev/null 2>&1
  pyenv init - | source
end

set --export VIRTUAL_ENV_DISABLE_PROMPT 1
. ~/envs/default/bin/activate.fish

# Direnv
if command -v direnv 1>/dev/null 2>&1
  direnv hook fish | source
end

# NVM
set --export NVM_DIR $HOME/.nvm
function nvm
  bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end
