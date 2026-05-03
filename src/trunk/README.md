
# Trunk (Rust WASM bundler) (trunk)

Installs the Trunk WASM web application bundler from trunkrs.dev. Optionally adds the wasm32-unknown-unknown Rust target.

## Example Usage

```json
"features": {
    "ghcr.io/mrhornsby/trunk-devcontainer-feature/trunk:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | Trunk version to install (e.g. 0.21.14) or 'latest'. | string | latest |
| installWasmTarget | Run `rustup target add wasm32-unknown-unknown` if rustup is available. | boolean | true |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/mrhornsby/trunk-devcontainer-feature/blob/main/src/trunk/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
