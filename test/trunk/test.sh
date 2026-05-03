#!/usr/bin/env bash
set -e
source dev-container-features-test-lib

check "trunk version"  trunk --version
check "trunk on PATH"  bash -c 'command -v trunk | grep -q /usr/local/bin/trunk'

if command -v rustup >/dev/null 2>&1; then
    check "wasm32 target installed"  bash -c 'rustup target list --installed | grep -q wasm32-unknown-unknown'
fi

reportResults
