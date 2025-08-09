#!/usr/bin/env zsh

# Hint to commands that they should keep their output simple.
export TERM=dumb

# Share mise cache with the host.
mkdir -p /mnt/home/.cache/mise
rm -rf $HOME/.cache/mise
ln -s -t ~/.cache /mnt/home/.cache/mise

# Trust the mise configs in the dev container.
mise trust --yes --all

# Install tools and run init tasks inside an interactive login shell.
zsh -l -i -c '
mise use --yes --global usage
mise install --yes
mise run --continue-on-error --no-cache "init:**"
'

# This script should always succeed, even if the last command exits with a
# non-zero status code.
true
