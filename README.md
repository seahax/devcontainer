# Dev Container Docker Image

Docker image for VSCode dev containers.

- [Installation](#installation)
- [Tool Management](#tool-management)
- [Symlinked Configuration](#symlinked-configuration)
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

## Tool Management

[Mise](https://mise.com) provides specific tool versions per directory. Add a `mise.toml` file to the root of your repo. Configured tools will be installed automatically when the dev container is built.

```toml
[tools]
# NPM before Node, so that PATH resolution finds the correct NPM version.
npm = "latest"
node = "lts"
```

## Symlinked Configuration

Symlinks are automatically created in the dev container home directory referencing a limited set of configuration files in the host's home directory. 

- The `.aws` directory.
- The `.npmrc` file.
- The `.config/doctl/config.yaml` file.
  - Linked to `.config/doctl/seahax-devcontainer-config.yaml` on the host, because sharing doesn't work correctly. But, it's still useful to persist it outside the dev container so configuration only has to be done once and not after every rebuild.

## ZSH Startup Configuration

You can also extend the ZSH configuration for this dev container.

- The dev container `.zprofile` sources the host `.devcontainer/zprofile` file.
- The dev container `.zshrc` sources the host `.devcontainer/zshrc` file.

## Port Forwarding

The dev container is configured to automatically forward ports when processes in the container start listening for connections.
