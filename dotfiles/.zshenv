# When: Always
# For:
#   - Things that need to be updated frequently
#   - Things that are inherited by child shells

for file in /mnt/home/.devcontainer/zshenv*(N) .devcontainer/zshenv*(N); do
  source "$file"
done
