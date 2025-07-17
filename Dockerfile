FROM mcr.microsoft.com/devcontainers/base:ubuntu
ARG TARGETARCH

SHELL ["/usr/bin/zsh", "-l", "-c"]
ENTRYPOINT ["/usr/bin/zsh", "-l"]

RUN --mount=type=secret,id=github_token,env=GITHUB_TOKEN

# Install global packages and tools
RUN <<EOF
  set -e
  install -dm 755 /etc/apt/keyrings
  wget -qO - https://mise.jdx.dev/gpg-key.pub | \
    gpg --dearmor | \
    tee /etc/apt/keyrings/mise-archive-keyring.gpg 1> /dev/null
  echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=${TARGETARCH}] https://mise.jdx.dev/deb stable main" | \
    tee /etc/apt/sources.list.d/mise.list
  apt update -y
  apt install -y git vim mise
EOF

# Initialize the user
USER vscode
WORKDIR /home/vscode
COPY --chown=vscode:vscode dotfiles/ ./
RUN sudo chsh -s /usr/bin/zsh vscode
RUN sudo mkdir -p /workspaces/.config
RUN sudo ln -s "$HOME/.config/mise/config.toml" /workspaces/.config/mise.toml
RUN mise trust /workspaces/.config/mise.toml
RUN mise install -q -y
