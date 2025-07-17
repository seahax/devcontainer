# Dev Container Docker Image

Docker image for Dev Containers with pre-configured development tools.

## Tools

- git
- vim
- mise
  - aws
  - doctl
  - node
  - pnpm
  - python
  - go
  - java
  - rustc

## Getting Started

1. Copy the `.devcontainer` directory to the root of your project.
2. Open the project in VS Code and select "Reopen in Container" from the
   Command Palette (Ctrl+Shift+P).
3. Run `npm login` to authenticate with npm if needed.
4. Run `aws login

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
