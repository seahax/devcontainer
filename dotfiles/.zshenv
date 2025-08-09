# When: Always
# For:
#   - Things that need to be updated frequently
#   - Things that are inherited by child shells

if [ -f /mnt/home/.devcontainer/zshenv ]; then
  source /mnt/home/.devcontainer/zshenv
fi

if [ -f .devcontainer/zshenv ]; then
  source .devcontainer/zshenv
fi
