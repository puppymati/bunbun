# bunbun

A Nix flake that packages [Bun](https://bun.sh) and keeps it up to date faster than nixpkgs.

## Usage

```nix
# flake.nix
inputs.bunbun.url = "github:puppymati/bunbun";
inputs.bunbun.inputs.nixpkgs.follows = "nixpkgs";
```

Then apply the overlay so `pkgs.bun` is replaced:

```nix
nixpkgs.overlays = [ inputs.bunbun.overlays.default ];
```

Or use the package directly:

```nix
inputs.bunbun.packages.${system}.default
```

## Updating

Change `version` in `bun.nix`, then get the new hashes:

```bash
nix store prefetch-file --hash-type sha256 --json \
  "https://github.com/oven-sh/bun/releases/download/bun-vVERSION/bun-linux-x64.zip"
```

## License

MIT
