# When: On new interactive shells
# For:
#   - Aliases
#   - Functions
#   - Prompt Config
#   - Things that are not inherited by child shells

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=devcontainers
DISABLE_UNTRACKED_FILES_DIRTY=true
DISABLE_MAGIC_FUNCTIONS=true
DISABLE_AUTO_TITLE=true
plugins=(vscode git mise)
zstyle ':omz:update' mode disabled
zstyle ":completion:*:commands" rehash 1
source $ZSH/oh-my-zsh.sh

eval "$(mise activate zsh)"

if [ -f /mnt/home/.devcontainer/zshrc ]; then
  source /mnt/home/.devcontainer/zshrc
fi

if [ -f .devcontainer/zshrc ]; then
  source .devcontainer/zshrc
fi
