# When: On login (interactive)
# For:
#   - Global environment variables (eg. PATH, EDITOR, etc.)
#   - Things that are inherited by child shells

export LANG=en_US.UTF-8
export EDITOR=vim
export NPM_CONFIG_UPDATE_NOTIFIER=false

path=($HOME/.local/share/mise/shims $path)

if [ -f /mnt/home/.devcontainer/zprofile ]; then
  source /mnt/home/.devcontainer/zprofile
fi

source "$HOME/.zshrc"
