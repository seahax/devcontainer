#!/usr/bin/env zsh

mise trust --yes --all
mise install --yes
mise run --continue-on-error --jobs=1 --no-cache "init:**"
true
