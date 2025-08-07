# Dev Container Docker Image

Docker image for Dev Containers with pre-configured development tools.

- [Installation](#installation)
- [Tool Management](#tool-management)
- [Symlinked Configuration](#symlinked-configuration)
- [ZSH Startup Configuration](#zsh-startup-configuration)
- [Port Forwarding](#port-forwarding)


## Installation

1. Copy the [.devcontainer.json](.devcontainer.json) file from this repo, into the root of your project repo. This should be the only _required_ configuration.
2. (Optional) Add a [mise.toml](#tools-mise) to the repo root with tool version configurations for your project.
3. (Optional) Copy the [PREREQUISITES_MACOS.md](PREREQUISITES_MACOS.md) file into the project repo.
4. Complete the [prerequisites](PREREQUISITES_MACOS.md) to make sure your system (host) is ready to run dev containers.
5. Open the repo root directory in VSCode (if you haven't already).
6. Open the command palette (Command+Shift+P) and select "Reopen in Container".

Make sure to rebuild the dev container occasionally to pull in any updates.

## Tool Management

[Mise](https://mise.com) provides specific tool versions per directory. Add a `mise.toml` file to the root of your repo. Configured tools will be installed automatically when the dev container is built.

```toml
[settings]
experimental = true

[tools]
node = "lts"

[hooks]
postinstall = "npm i -g npm@latest"
```

## Symlinked Configuration

Symlinks are automatically created in the dev container home directory referencing a limited set of configuration files in the host's home directory. 

- Dev container `$HOME/.aws` is a link to host `$HOME/.aws`.
- Dev container `$HOME/.npmrc` is a link to host `$HOME/.npmrc`.
- Dev container `$HOME/.config/doctl/config.yaml` is a link to host `$HOME/.config/doctl/seahax-devcontainer-config.yaml`.

## ZSH Startup Configuration

You can also extend the ZSH configuration for this dev container.

- Dev container `$HOME/.zprofile` sources host `$HOME/.devcontainer/zprofile`.
- Dev container `$HOME/.zshrc` sources host `$HOME/.devcontainer/zshrc`.

## Port Forwarding

The dev container is configured to automatically forward ports when processes in the container start listening for connections.
