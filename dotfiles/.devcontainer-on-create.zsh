#!/usr/bin/env zsh

# Install Mise tools if the repo has a local Mise config.
mise trust -a
mise install -y

# Restore JS package manager dependencies.
[ -f package-lock.json ] && npm ci
[ -f yarn.lock ] && yarn install --frozen-lockfile
[ -f pnpm-lock.yaml ] && pnpm install --frozen-lockfile

# Create container symlinks to remote configs.
typeset -A configs=(
  [.ssh/id_rsa]=.ssh/id_rsa
  [.ssh/id_ed25519]=.ssh/id_ed25519
  [.aws]=.aws
  [.npmrc]=.npmrc
  [.config/doctl/seahax-devcontainer-config.yaml]=.config/doctl/config.yaml
)
for remote_config local_config in ${(kv)configs}; do
  remote_config="${HOME}/.remote/${remote_config}"
  local_config="${HOME}/${local_config}"
  if [ -e "${local_config}" ]; then return; fi
  echo "Linking \"${remote_config}\" to \"${local_config}\""
  mkdir -p "$(dirname "${local_config}")"
  ln -s "/${remote_config}" "${local_config}"
done

echo -e '\e[0;93m
Dev container setup is complete!

You can manually install any of your local VSCode extensions that are not
included in the dev container by following these steps:

  1. Open the VSCode command palette (Cmd+Shift+P on mac).
  2. Paste the "workbench.extensions.installLocalExtensions" command ID
     and press enter.
  3. Select the local extensions you want to install in the dev container
     and click "OK".
\e[0m'

true
