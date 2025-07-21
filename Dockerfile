FROM mcr.microsoft.com/devcontainers/base:ubuntu
ARG TARGETARCH

SHELL ["/usr/bin/zsh", "-l", "-c"]
ENTRYPOINT ["/usr/bin/zsh", "-l"]

# Install global packages and tools
RUN <<EOF
  set -e
  install -dm 755 /etc/apt/keyrings
  wget -qO - https://mise.jdx.dev/gpg-key.pub | \
    gpg --dearmor | \
    tee /etc/apt/keyrings/mise-archive-keyring.gpg 1> /dev/null
  echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=${TARGETARCH}] https://mise.jdx.dev/deb stable main" | \
    tee /etc/apt/sources.list.d/mise.list
  sed -i '/path-exclude/s/^/#/' /etc/dpkg/dpkg.cfg.d/excludes
  apt-get update -y
  apt-get upgrade -y
  apt-get install -y git vim mise
  apt-get --reinstall install man-db manpages manpages-dev manpages-posix manpages-posix-dev -y
  apt-get clean -y
  apt-get autoclean -y
  apt-get autoremove -y
  mv /usr/bin/man.REAL /usr/bin/man
  mandb -c
EOF

# Initialize system config
COPY rootfiles/ /

# Initialize user config
USER vscode
WORKDIR /home/vscode
COPY --chown=vscode:vscode dotfiles/ ./
RUN sudo chsh -s /usr/bin/zsh vscode
RUN sudo mkdir -p /workspaces/.config
