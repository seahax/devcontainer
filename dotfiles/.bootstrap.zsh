#!/usr/bin/env zsh

# Hint to commands that they should keep their output simple.
export TERM=dumb

# Share mise cache with the host.
mkdir -p /mnt/home/.cache/mise
rm -rf $HOME/.cache/mise
ln -s -t ~/.cache /mnt/home/.cache/mise

# Install tools and run init tasks inside a (non-interactive) login shell.
zsh -l -c '
mise trust --yes --all
mise use --yes --global usage
mise install --yes --jobs=1
mise run --jobs=1 --continue-on-error --no-cache "init:**"
'

# This script should always succeed, even if the last command exits with a
# non-zero status code.
true
