#!/usr/bin/env zsh

# Hint to commands that they should keep their output simple.
export TERM=dumb

if [ ! -e /mnt/home ]; then
  echo -e '\e[1;33mWARNING: Home directory not mounted at /mnt/home\e[0m'
else
  # Share mise cache with the host.
  mkdir -p /mnt/home/.cache/mise
  rm -rf $HOME/.cache/mise
  ln -s -t ~/.cache /mnt/home/.cache/mise
fi

# Install tools and run init tasks inside a (non-interactive) login shell.
zsh -l -c "$(cat <<'EOF'
echo "Installing tools"
mise trust --quiet --yes --all
mise install --quiet --yes --jobs=1
# The `usage` tool is required for zsh completions.
mise use --silent --yes --global usage &>/dev/null
echo "Running init tasks"
for INIT_TASK in "${(@f)$(mise tasks ls --hidden --local --json | jq -r '.[].name' | { grep -E '^devcontainer_init([:_]|$)' || true })}"; do
  mise run --jobs=1 --continue-on-error --no-cache "$INIT_TASK"
done
EOF
)"

# This script should always succeed, even if the last command exits with a
# non-zero status code.
true
