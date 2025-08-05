#!/usr/bin/env zsh
set -e

# Reinstall man pages to enable them (excluded by minimized Ubuntu).
apt-get install -y --reinstall \
  man-db manpages \
  manpages-dev \
  manpages-posix \
  manpages-posix-dev \
  ;

# Restore the real man command binary.
mv /usr/bin/man.REAL /usr/bin/man

# Rebuild the man database.
mandb -c
