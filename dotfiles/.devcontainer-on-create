#!/usr/bin/env zsh

# Install Mise tools if the repo has a local Mise config.
mise trust -a
mise install -q -y

# Restore JS package manager dependencies.
[ -f package-lock.json ] && npm ci
[ -f yarn.lock ] && yarn install --frozen-lockfile
[ -f pnpm-lock.yaml ] && pnpm install --frozen-lockfile

# Setup persistent host config
link_config () {
  local remote_config="$HOME/.remote/${1}"
  local local_config="$HOME/${2:-$1}"
  local_config="${local_config%%/}"
  if [ -e "$local_config" ]; then return; fi
  echo "Linking \"${remote_config%%/}\" to \"$local_config\""
  case $i in
    */) touch "$remote_config";;
    *) mkdir -p "$(dirname "$remote_config")";;
  esac
  mkdir -p "$(dirname "$local_config")"
  ln -s "$remote_config" "$local_config"
}
link_config .aws/
link_config .npmrc
# Remote doctl config does not work. Using a separate one for persistence only.
link_config .config/doctl/config.yaml
link_config "Library/Application Support/doctl/seahax-devcontainer-doctl.yaml" .config/doctl/config.yaml

true
