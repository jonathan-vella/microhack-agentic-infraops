FROM mcr.microsoft.com/devcontainers/javascript-node:22-bookworm

# Refresh Microsoft GPG signing key to prevent apt failures during feature installation
RUN curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft-archive-keyring.gpg \
  && if [ -f /etc/apt/sources.list.d/microsoft.list ]; then \
  sed -i 's|^\(deb\s\)|deb [signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg] |' /etc/apt/sources.list.d/microsoft.list; \
  fi \
  && apt-get update
