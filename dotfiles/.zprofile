# When: On login (interactive)
# For:
#   - Global environment variables (eg. PATH, EDITOR, etc.)
#   - Things that are inherited by child shells
#   - Things that are only applicable after logging in

export LANG=en_US.UTF-8
export EDITOR=vim
export GIT_EDITOR=vim
export NPM_CONFIG_GLOBALCONFIG=/etc/npmrc

path=($HOME/.local/share/mise/shims $path)

for file in /mnt/home/.devcontainer/zprofile*(N) .devcontainer/zprofile*(N); do
  source "$file"
done
