# When: On login (interactive)
# For:
#   - Global environment variables (eg. PATH, EDITOR, etc.)
#   - Things that are inherited by child shells

export LANG=en_US.UTF-8
export EDITOR=vim
export AWS_REGION=us-east-1
export PNPM_HOME="$HOME/.pnpm"

path=(
  $PNPM_HOME
  $HOME/.local/bin
  $HOME/.local/share/mise/shims
  $path
)

mkdir -p "$HOME/.local/bin"
mkdir -p "$PNPM_HOME"

for file in "$HOME/.zprofile.d/*.zsh"(N); do
  source "$file"
done

source "$HOME/.zshrc"

true
