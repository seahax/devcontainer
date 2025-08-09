#!/usr/bin/env zsh

export TERM=dumb
mkdir -p /mnt/home/.cache/mise
rm -rf $HOME/.cache/mise
ln -s -t ~/.cache /mnt/home/.cache/mise
mise trust --yes --all
mise use --yes --global usage
mise install --yes
mise run --continue-on-error --no-cache "init:**"
true
