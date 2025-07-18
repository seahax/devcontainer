#!/usr/bin/env zsh

# Install Mise tools if the repo has a local Mise config.
mise trust -a
mise install -q -y

# Restore JS package manager dependencies.
[ -f package-lock.json ] && npm ci
[ -f yarn.lock ] && yarn install --frozen-lockfile
[ -f pnpm-lock.yaml ] && pnpm install --frozen-lockfile

# Create container symlinks to remote configs.
link_config () {
  local remote_config="$HOME/.remote/${1%/}"
  local local_config="$HOME/${${2%/}:-${1%/}}"
  if [ -e "$local_config" ]; then return; fi
  echo "Linking \"${remote_config}\" to \"${local_config}\""
  mkdir -p "$(dirname "${local_config}")"
  ln -s "${remote_config}" "${local_config}"
}
link_config .ssh/id_rsa
link_config .ssh/id_ed25519
link_config .aws/
link_config .npmrc
link_config .config/doctl/seahax-devcontainer-config.yaml .config/doctl/config.yaml

true
