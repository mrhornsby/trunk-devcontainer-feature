# trunk-devcontainer-feature

A [Dev Container Feature](https://containers.dev/implementors/features/) that installs the [Trunk](https://trunkrs.dev) WASM web application bundler and optionally adds the `wasm32-unknown-unknown` Rust target.

## Usage

Add the feature to your `devcontainer.json`:

```json
{
  "features": {
    "ghcr.io/mrhornsby/trunk-devcontainer-feature/trunk:1": {}
  }
}
```

### With the Rust feature

```json
{
  "features": {
    "ghcr.io/devcontainers/features/rust:1": {},
    "ghcr.io/mrhornsby/trunk-devcontainer-feature/trunk:1": {}
  }
}
```

## Options

| Option | Type | Default | Description |
|---|---|---|---|
| `version` | string | `latest` | Trunk version to install (e.g. `0.21.14`) or `latest` |
| `installWasmTarget` | boolean | `true` | Run `rustup target add wasm32-unknown-unknown` if rustup is available |

## Examples

Install a specific version without the WASM target:

```json
{
  "features": {
    "ghcr.io/mrhornsby/trunk-devcontainer-feature/trunk:1": {
      "version": "0.21.14",
      "installWasmTarget": false
    }
  }
}
```

## Supported architectures

- `x86_64` / `amd64`
- `aarch64` / `arm64`
