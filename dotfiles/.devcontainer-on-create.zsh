#!/usr/bin/env zsh
# Run all of the commands in the "customizations.ON_CREATE_COMMANDS" array of the
# dev container config file.

export WORKSPACE="$PWD"

mise trust -a

if [ -f .devcontainer.json ]; then
  CONFIG_FILE=".devcontainer.json"
elif [ -f .devcontainer/devcontainer.json ]; then
  CONFIG_FILE=".devcontainer/devcontainer.json"
fi

if [ -n "$CONFIG_FILE" ]; then
  DEFAULT_SHELL="$(getent passwd $LOGNAME | cut -d: -f7)"
  ON_CREATE_COMMANDS=("${(@f)"$(sed 's/\/\/.*//g' "$CONFIG_FILE" | jq -r '.customizations?["$onCreateCommands"]?.[]?')"}")

  for ON_CREATE_COMMAND in "${ON_CREATE_COMMANDS[@]}"; do
    echo "> $ON_CREATE_COMMAND"
    (cd "$HOME" && echo "$ON_CREATE_COMMAND" | "$DEFAULT_SHELL")
  done
fi

mise install -y

true
