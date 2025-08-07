#!/usr/bin/env zsh
set -e

# Cleanup apt cache and remove unnecessary packages.
apt-get clean -y
apt-get autoremove -y
