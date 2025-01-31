# https://www.gnu.org/software/emacs/manual/html_node/efaq/Colors-on-a-TTY.html
set -xg LD_LIBRARY_PATH /usr/local/lib
set -xg COLORTERM truecolor
set -xg TERM xterm
set -xg EDITOR vim
set -xg POETRY_VIRTUALENVS_IN_PROJECT true
set -xg DOCKER_BUILDKIT 1
set -xg LANG en_US.UTF-8

# PATH settings
fish_add_path /snap/bin /opt/homebrew/bin /usr/local/bin
fish_add_path $HOME/Bin $HOME/.local/bin
fish_add_path $HOME/go/bin $HOME/.platformio/penv/bin $HOME/Documents/flutter/bin
fish_add_path ./node_modules/.bin

alias 'emacs'='emacs -nw'
alias 'k'='kubectl'
alias 'kx'='kubectx'
alias 'kn'='kubens'
alias 'kk'='echo Context: (kubectx -c) \nNamespace: (kubens -c)'
alias 'nvim'='TERM=st SHELL=sh /usr/bin/env nvim'
alias 'gs'='git switch (git branch -a | fzf | sed -e "s/remotes\/origin\///g" | tr -d " ")'
alias 'gg'='git status'
alias 'gd'='git diff HEAD'
alias 'lg'='lazygit'
alias 'goto'='cd (dirname (fzf))'
function quell; ps -ux | fzf | awk '{print $2}' | xargs -I'{}' bash -c "echo kill $argv {}; kill $argv {}; ps --pid {}"; end

alias mqdh='/Applications/Meta\ Quest\ Developer\ Hub.app/Contents/MacOS/Meta\ Quest\ Developer\ Hub --remote-debugging-port=8315 --remote-allow-origins=http://localhost:8315 &; open http://localhost:8315; fg'
alias ss='adb shell am start-foreground-service com.amazevr.mdm/com.amazevr.mdm.AdminService'
alias sss='adb shell am force-stop com.amazevr.mdm'
alias s='adb shell am start -n com.android.settings/.Settings'
alias m='cd ~/work/amaze/mverse-backend'

# Pyenv
set -xg PYENV_ROOT $HOME/.pyenv
set -xg PATH "$PATH:$PYENV_ROOT/bin:$PYENV_ROOT/shims"
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
