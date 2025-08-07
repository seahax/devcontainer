#!/usr/bin/env zsh

# Create container symlinks to remote configs.
typeset -A configs=(
  [.aws]=.aws
  [.npmrc]=.npmrc
  [.config/doctl/config.yaml]=.config/doctl/seahax-devcontainer-config.yaml
)
for local_config remote_config in ${(kv)configs}; do
  local_config="${HOME}/${local_config}"
  remote_config="${HOME}/.remote/${remote_config}"
  echo "Linking \"${local_config}\" to \"${remote_config}\""
  mkdir -p "$(dirname "$local_config")"
  ln -s "$remote_config" "$local_config"
done

# Install Mise tools if the repo has a local Mise config.
mise trust -a
mise install -y

# Restore JS package manager dependencies.
[ -f package-lock.json ] && npm ci
[ -f pnpm-lock.yaml ] && pnpm install --frozen-lockfile
[ -f yarn.lock ] && yarn install --frozen-lockfile

true
