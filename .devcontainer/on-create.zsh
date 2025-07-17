# Install Mise tools if the repo has a local Mise config.
mise install -q -y

# Restore JS package manager dependencies.
[ -f package-lock.json ] && npm ci
[ -f yarn.lock ] && yarn install --frozen-lockfile
[ -f pnpm-lock.yaml ] && pnpm install --frozen-lockfile

# Link mounted host config and credentials files.
HOST_LINKED_CONFIGS=(
  .aws .aws
  .npmrc .npmrc
)
for ((i = 1; i <= $#HOST_LINKED_CONFIGS; i += 2)); do
  local host_config="${HOST_LINKED_CONFIGS[i]}"
  local local_config="${HOST_LINKED_CONFIGS[i+1]}"
  if [ -e "$HOME/.host/$host_config" ] && [ ! -e "$HOME/$local_config" ]; then
    echo "Linking $HOME/.host/$host_config to $HOME/$local_config"
    mkdir -p "$(dirname "$HOME/$local_config")"
    ln -s "$HOME/.host/$host_config" "$HOME/$local_config"
  fi
done

# TODO: Pull in the doctl access token if it exists.

true
