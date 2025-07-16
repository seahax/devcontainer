FROM mcr.microsoft.com/devcontainers/base:ubuntu
ARG TARGETARCH

SHELL ["/usr/bin/zsh", "-l", "-c"]
ENTRYPOINT ["/usr/bin/zsh", "-l"]

# Install OS packages
RUN apt-get update -y && apt-get install -y git vim
RUN yes | unminimize

# Initialize the user
USER vscode
WORKDIR /home/vscode
COPY --chown=vscode:vscode dotfiles .
RUN sudo chsh -s /usr/bin/zsh vscode

# Install user-land tools
RUN mkdir -p .tmp
RUN <<EOF
  ASDF_URL=$(curl -Ls \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    https://api.github.com/repos/asdf-vm/asdf/releases/latest | \
    jq '.assets[].browser_download_url' --raw-output | \
    grep -- "-linux-${TARGETARCH}.tar.gz\$")
  wget "$ASDF_URL" -nv -O .tmp/asdf.tar.gz
  tar -xvf .tmp/asdf.tar.gz -C .asdf/bin
  rm .tmp/asdf.tar.gz
EOF
RUN asdf plugin add go-sdk && asdf set go-sdk latest
RUN asdf plugin add nodejs && asdf set nodejs lts
RUN asdf plugin add pnpm && asdf set pnpm latest
RUN asdf plugin add awscli && asdf set awscli latest
RUN asdf install
RUN go install github.com/digitalocean/doctl/cmd/doctl@latest
