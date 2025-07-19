# Dev Container Docker Image

Docker image for Dev Containers with pre-configured development tools.

## Getting Started

1. Copy the `.devcontainer` directory to the root of your project.
2. Open the project in VS Code and select "Reopen in Container" from the
   Command Palette (Ctrl+Shift+P).

Make sure to rebuild the dev container occasionally to pull in any updates.

If you don't want to copy the whole devcontainer config, then the following is the minimum required config.

```json
{
  "dockerFile": "ghcr.io/seahax/devcontainer:latest",
  "mounts": ["source=${localEnv:HOME}${localEnv:USERPROFILE},target=/home/vscode/.remote,type=bind"],
  "onCreateCommand": "$HOME/.devcontainer-on-create.zsh",
}
```

## Tools

> Depends on running the`$HOME/.devcontainer-on-create.zsh` container script using the Dev Container [onCreateCommand](https://containers.dev/implementors/json_reference/#lifecycle-scripts).

[Mise](https://mise.com) is installed as the preferred tool manager.

Add a [`mise.toml`](https://mise.jdx.dev/configuration.html) to the root of your repo. Tools will be installed automatically when the dev container is (re-)built.

## Shared Configs

> Depends on running the`$HOME/.devcontainer-on-create.zsh` container script using the Dev Container [onCreateCommand](https://containers.dev/implementors/json_reference/#lifecycle-scripts).

Symlinks are automatically created in the container home directory that point to files in the remote home directory (mounted at `/home/vscode/.remote`).

- SSH (RSA): `.ssh/id_rsa`
- SSH (EdDSA): `.ssh/id_ed25519`
- AWS: `.aws`
- NPM: `.npmrc`
- Doctl: `.config/doctl/config.yaml`
  - NOTE: This is _not_ linked to the remote Doctl config, because it's not safe
    to share. It's linked to a _separate_ file purely for persistence across
    rebuilds. Doctl credentials will need to be setup once in the devcontainer.

A custom `onCreateCommand` can be used to symlink additional configs from `/home/vscode/.remote` into the container home directory if required.
