FROM mcr.microsoft.com/devcontainers/base:ubuntu
ARG TARGETARCH

# Run setup scripts
COPY setupfiles /tmp/setupfiles
WORKDIR /tmp/setupfiles
RUN ./0-apt-init
RUN ./1-enable-man-pages
RUN ./2-install-packages
RUN ./3-apt-cleanup
WORKDIR /
RUN rm -rf /tmp/setupfiles

# Initialize system config
COPY rootfiles/ /

# Initialize user config
USER vscode
WORKDIR /home/vscode
COPY --chown=vscode:vscode dotfiles/ ./
RUN sudo chsh -s /usr/bin/zsh vscode

# Use login shell (ignored in dev container)
ENTRYPOINT ["/usr/bin/zsh", "-l"]
