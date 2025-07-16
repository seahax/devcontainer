# When: On login (interactive)
# For:
#   - Global environment variables (eg. PATH, EDITOR, etc.)
#   - Things that are inherited by child shells

export LANG=en_US.UTF-8
export EDITOR=vim
export ASDF_DIR="$HOME/.asdf"
export ASDF_DATA_DIR="$ASDF_DIR"
export NODE_OPTIONS="$NODE_OPTIONS --no-deprecation"
export PNPM_HOME="$HOME/.pnpm"
export AWS_REGION=us-west-2

path=(
  $HOME/bin
  $HOME/.local/bin
  $HOME/.asdf/bin
  $HOME/.asdf/shims
  $HOME/go/bin
  $PNPM_HOME
  $path
)

mkdir -p "$HOME/bin"
mkdir -p "$HOME/.local/bin"
mkdir -p "$ASDF_DIR/bin"
mkdir -p "$ASDF_DIR/shims"
mkdir -p "$ASDF_DATA_DIR"
mkdir -p "$PNPM_HOME"

for file in "$HOME/.zprofile.d/*.zsh"(N); do
  source "$file"
done

for file in "/workspaces/devcontainer/.zprofile.d/*.zsh"(N); do
  source "$file"
done

source "$HOME/.zshrc"
