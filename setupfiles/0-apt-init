#!/usr/bin/env zsh
set -e

# Remove path exclusions from dpkg configuration so that packages that were
# stubbed by minimizing Ubuntu can be reinstalled (re-enabled).
sed -i '/path-exclude/s/^/#/' /etc/dpkg/dpkg.cfg.d/excludes

# Add mise repository and GPG key.
install -dm 755 /etc/apt/keyrings
wget -qO - https://mise.jdx.dev/gpg-key.pub | \
  gpg --dearmor | \
  tee /etc/apt/keyrings/mise-archive-keyring.gpg 1> /dev/null
echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=${TARGETARCH}] https://mise.jdx.dev/deb stable main" | \
  tee /etc/apt/sources.list.d/mise.list

# Update apt repositories and upgrade existing packages.
apt-get update -y
apt-get upgrade -y
