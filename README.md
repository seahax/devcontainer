# Dev Container Docker Image

Docker image for Dev Containers with pre-configured development tools.

## Tools

Tools are provided by [Mise](https://mise.com), and the following tools are pre-installed in the container:

- AWS CLI
- Digital Ocean CLI (Doctl)
- Node.js
- PNPM
- Python
- Go
- Java
- Rust

## Shared Configs

Symlinks are created in the container home directory that point to files in the remote home directory.

> Requires the [.devcontainer/on-create.zsh](.devcontainer/on-create.zsh) script.

- SSH (RSA): `.ssh/id_rsa`
- SSH (EdDSA): `.ssh/id_ed25519`
- AWS: `.aws`
- NPM: `.npmrc`
- Doctl: `.config/doctl/config.yaml`
  - NOTE: This is _not_ linked to the remote Doctl config, because it's not safe
    to share. It's linked to a _separate_ file purely for persistence across
    rebuilds. Doctl credentials will need to be setup once in the devcontainer.

## Getting Started

1. Copy the `.devcontainer` directory to the root of your project.
2. Open the project in VS Code and select "Reopen in Container" from the
   Command Palette (Ctrl+Shift+P).

Make sure to rebuild the dev container occasionally to pull in any updates.

If you don't want the VSCode customizations and settings, then this is the minimal recommended `devcontainer.json` content.

```json
{
  "dockerFile": "ghcr.io/seahax/devcontainer:latest",
  "initializeCommand": "docker pull ghcr.io/seahax/devcontainer:latest",
  "features": {
    "ghcr.io/devcontainers/features/docker-in-docker:2": { }
  },
	"mounts": [
		"source=${localEnv:HOME}${localEnv:USERPROFILE},target=/home/vscode/.remote,type=bind"
	],
  "onCreateCommand": "zsh .devcontainer/on-create.zsh",
}
```
