#!/usr/bin/env bash
set -euo pipefail

VERSION="${VERSION:-latest}"
INSTALLWASMTARGET="${INSTALLWASMTARGET:-true}"

if [ "$(id -u)" -ne 0 ]; then
    echo "ERROR: install.sh must run as root" >&2
    exit 1
fi

if ! command -v curl &>/dev/null; then
    apt-get update -y
    apt-get install -y --no-install-recommends curl ca-certificates
fi

# Resolve "latest" to a concrete version number from the GitHub releases API
if [ "${VERSION}" = "latest" ]; then
    VERSION=$(curl -fsSL https://api.github.com/repos/trunk-rs/trunk/releases/latest \
              | grep '"tag_name"' | head -n1 | sed -E 's/.*"v?([^"]+)".*/\1/')
fi
VERSION="${VERSION#v}"

case "$(uname -m)" in
    x86_64|amd64)  TARGET="x86_64-unknown-linux-gnu" ;;
    aarch64|arm64) TARGET="aarch64-unknown-linux-gnu" ;;
    *) echo "ERROR: unsupported architecture $(uname -m)" >&2; exit 1 ;;
esac

TMP=$(mktemp -d); trap 'rm -rf "$TMP"' EXIT
ASSET="trunk-${TARGET}.tar.gz"
BASE="https://github.com/trunk-rs/trunk/releases/download/v${VERSION}"

echo "Downloading trunk ${VERSION} (${TARGET})..."
curl -fsSL -o "${TMP}/${ASSET}"        "${BASE}/${ASSET}"
curl -fsSL -o "${TMP}/${ASSET}.sha256" "${BASE}/${ASSET}.sha256"

DIGEST=$(tr -d '[:space:]' < "${TMP}/${ASSET}.sha256")
echo "${DIGEST}  ${TMP}/${ASSET}" | sha256sum -c -

tar -xzf "${TMP}/${ASSET}" -C "${TMP}"
install -m 0755 "${TMP}/trunk" /usr/local/bin/trunk

if [ "${INSTALLWASMTARGET}" = "true" ]; then
    RUSTUP="$(command -v rustup 2>/dev/null || echo /usr/local/cargo/bin/rustup)"
    if [ -x "${RUSTUP}" ]; then
        echo "Adding wasm32-unknown-unknown target..."
        "${RUSTUP}" target add wasm32-unknown-unknown
    else
        echo "WARN: rustup not found; skipping wasm32-unknown-unknown target" >&2
    fi
fi

trunk --version
