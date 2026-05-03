#!/usr/bin/env bash
set -e
source dev-container-features-test-lib

check "trunk version"       trunk --version
check "trunk on PATH"       bash -c 'command -v trunk | grep -q /usr/local/bin/trunk'
check "rustup available"    bash -c 'command -v rustup'
check "wasm32 target installed"  bash -c 'rustup target list --installed | grep -q wasm32-unknown-unknown'

reportResults
