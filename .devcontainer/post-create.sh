#!/bin/sh
set -e

# MkDocs documentation dependencies
pip install -r requirements-docs.txt

# npm globals
npm install -g markdownlint-cli2

# k6 load testing (challenge 5)
# The k6 apt repo only ships amd64/i386; install from GitHub release for any arch.
K6_VERSION=$(curl -fsSL "https://api.github.com/repos/grafana/k6/releases/latest" | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/')
ARCH=$(dpkg --print-architecture)
curl -fsSL "https://github.com/grafana/k6/releases/download/v${K6_VERSION}/k6-v${K6_VERSION}-linux-${ARCH}.tar.gz" \
  | sudo tar xz --strip-components=1 -C /usr/local/bin k6-v${K6_VERSION}-linux-${ARCH}/k6
