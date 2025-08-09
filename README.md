# Dev Container Docker Image

Docker image for VSCode dev containers.

- [Installation](#installation)
- [Bootstrapping](#bootstrapping)
  - [Install project tools.](#install-project-tools)
  - [Run initialization tasks.](#run-initialization-tasks)
- [ZSH Configuration](#zsh-configuration)
- [Port Forwarding](#port-forwarding)

## Installation

1. Copy the recommended [.devcontainer.json](.devcontainer.json) file into your project.
2. (Optional) Add a [mise.toml](#tools-mise) file to your project.
3. (Optional) Copy the [PREREQUISITES.md](PREREQUISITES.md) file into your project.
4. Complete the [prerequisites](PREREQUISITES.md) to make sure your system (host) is ready to run dev containers.
5. Open the repo root directory in VSCode (if you haven't already).
6. Open the command palette (Command+Shift+P or Control+Shift+P) and select "Reopen in Container".

Rebuild the dev container occasionally to pull in container updates. Rebuilding is also a good way to "reset" if something isn't behaving as expected (ie. turning it off and on again).

## Bootstrapping

The recommended dev container config includes an `onCreateCommand` hook that executes the `~/.bootstrap.zsh` script that is embedded in the dev container image. This script performs the following actions inside the dev container on container creation:

1. Install project tools.
2. Run initialization tasks.

### Install project tools.

Define [Mise tools](https://mise.jdx.dev/dev-tools/) to automatically install on container creation.

```toml
[tools]
# NPM is before Node so that the explicitly installed version is resolved
# before the version that is bundled with Node ($PATH ordering).
npm = "latest"
node = "22"
```

You can also apply changes to the Mise config file immediately by running the `mise install` command.

### Run initialization tasks.

Define [Mise `init:**` tasks](https://mise.jdx.dev/tasks/) to automatically run on container creation.

The recommended dev container config mounts the host's home directory inside the dev container at `/mnt/home`. This is useful for sharing configuration files with the host by symlinking them into the correct location in the dev container.

```toml
[tasks]
# Example: Share AWS configuration with the host.
"init:aws" = "ln -s -t ~ /mnt/home/.aws"
```

Initialization tasks are similar to adding additional commands to the the dev container `onCreateCommand` hook, but with the following differences:

- Tools and basic configs are setup first.
- Init tasks are run serially (when run automatically on container creation).
- Tasks can also be executed manually.
- Task ordering is configurable (alphabetical by default).

The init tasks are run inside a (non-interactive) login shell.

## ZSH Configuration

The ZSH configuration for this dev container can be extended from the host and from the project source (ie. the cloned repository).

- The built-in `~/.zshenv` script sources...
  - `/mnt/home/.devcontainer/zshenv*`
  - `/workspace/<name>/.devcontainer/zshenv*`
- The built-in `~/.zprofile` script sources...
  - `/mnt/home/.devcontainer/zprofile*`
  - `/workspace/<name>/.devcontainer/zprofile*`
- The built-in `~/.zshrc` script sources...
  - `/mnt/home/.devcontainer/zshrc*`
  - `/workspace/<name>/.devcontainer/zshrc*`

The [oh-my-zsh](https://ohmyz.sh/) initialization is delayed until after the above ZSH configuration files are sourced, so you can use them (specifically `zshrc`) to change settings and add plugins.

## Port Forwarding

The dev container VSCode settings are set to automatically forward ports when processes in the container start listening for connections.
