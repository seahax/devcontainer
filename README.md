# Dev Container Docker Image

Docker image for VSCode dev containers.

- [Installation](#installation)
  - [On Create Hook](#on-create-hook)
- [Tool Management](#tool-management)
- [ZSH Startup Configuration](#zsh-startup-configuration)
- [Port Forwarding](#port-forwarding)


## Installation

1. Copy the [.devcontainer.json](.devcontainer.json) file from this repo, into the root of your project repo. This should be the only _required_ configuration.
2. (Optional) Add a [mise.toml](#tools-mise) to the repo root with tool version configurations for your project.
3. (Optional) Copy the [PREREQUISITES.md](PREREQUISITES.md) file into the project repo.
4. Complete the [prerequisites](PREREQUISITES.md) to make sure your system (host) is ready to run dev containers.
5. Open the repo root directory in VSCode (if you haven't already).
6. Open the command palette (Command+Shift+P or Control+Shift+P) and select "Reopen in Container".

Rebuild the dev container occasionally to pull in any updates.

### On Create Hook

The recommended [.devcontainer.json](.devcontainer.json) file includes an `onCreateCommand` hook that runs the `~/.devcontainer-on-create.zsh` script which is built-in to the image. That script does two things:

1. It runs all commands in the dev container config `customizations.$onCommandConfigs` array.
2. It automatically installs your required tools (see the [Tool Management](#tool-management) section).

The `customizations.$onCommandConfigs` array is different from using an `onCreateCommand` object in the following ways:

- Commands are run sequentially (instead of in parallel).
- Commands are run in the dev container home directory (`/home/vscode`).
- The `WORKSPACE` environment variable contains the path of the opened directory (ie. the cloned repo root).

Example: Sharing NPM credentials (and config) with the host.

```json
{
  // Run the built-in on-create script.
  "onCreateCommand": "$HOME/.devcontainer-on-create.zsh",
  "mounts": [
    // Mount the host's home directory in the dev container.
    "source=${localEnv:HOME}${localEnv:USERPROFILE},target=/mnt/home,type=bind"
  ],
  "customizations": {
    "$onCreateCommands": [
      // Share the host's NPM credentials (and config).
      "ln -s /mnt/home/.npmrc",
      // Run mise install early so that NPM is available.
      "cd $WORKSPACE && mise install -y",
      // Restore JS dependencies with credentials.
      "cd $WORKSPACE && npm install"
    ]
  }
}
```

## Tool Management

[Mise](https://mise.com) is installed in the dev container image. Add a `mise.toml` file to the root of your repo to have tools installed automatically after the dev container is built (See the [On Create Hook](#on-create-hook) section)

```toml
[tools]
# NPM before Node, so that PATH resolution finds the correct NPM version.
npm = "latest"
node = "lts"
```

## ZSH Startup Configuration

You can extend the ZSH configuration for this dev container.

- The dev container `.zprofile` sources the host `.devcontainer/zprofile` file.
- The dev container `.zshrc` sources the host `.devcontainer/zshrc` file.

## Port Forwarding

The dev container is configured to automatically forward ports when processes in the container start listening for connections.
