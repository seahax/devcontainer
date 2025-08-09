# When: On new interactive shells
# For:
#   - Aliases
#   - Functions
#   - Prompt Config
#   - Things that are not inherited by child shells

eval "$(mise activate zsh)"

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=devcontainers
DISABLE_UNTRACKED_FILES_DIRTY=true
DISABLE_MAGIC_FUNCTIONS=true
DISABLE_AUTO_TITLE=true
plugins=(vscode git mise)
zstyle ':omz:update' mode disabled

for file in /mnt/home/.devcontainer/zshrc*(N) .devcontainer/zshrc*(N); do
  source "$file"
done

zstyle ":completion:*:commands" rehash 1
source $ZSH/oh-my-zsh.sh
