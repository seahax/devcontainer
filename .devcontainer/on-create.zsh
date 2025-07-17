# Install Mise tools if the repo has a local Mise config.
mise trust -a
mise install -q -y

# Restore JS package manager dependencies.
[ -f package-lock.json ] && npm ci
[ -f yarn.lock ] && yarn install --frozen-lockfile
[ -f pnpm-lock.yaml ] && pnpm install --frozen-lockfile

# Setup persistent host config
REMOTE_HOME_DIR="$HOME/.remote"
REMOTE_LINKED_CONFIGS=(
  .aws/config .aws/config
  .aws/credentials .aws/credentials
  .npmrc .npmrc
  # Host doctl config won't work. Using a separate one for persistence.
  "Library/Application Support/doctl/seahax-devcontainer-doctl.yaml" .config/doctl/config.yaml
)
for ((i = 1; i <= $#REMOTE_LINKED_CONFIGS; i += 2)); do
  local host_config="$REMOTE_HOME_DIR/${REMOTE_LINKED_CONFIGS[i]}"
  local local_config="$HOME/${REMOTE_LINKED_CONFIGS[i+1]}"
  if [ ! -e "$local_config" ]; then
    echo "Linking $host_config to $local_config"
    mkdir -p "$(dirname "$host_config")"
    touch "$host_config"
    mkdir -p "$(dirname "$local_config")"
    ln -s "$host_config" "$local_config"
  fi
done

true
