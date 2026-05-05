{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forEachSystem = f: builtins.listToAttrs (map (s: { name = s; value = f s; }) systems);
    in
    {
      overlays.default = final: prev: {
        bun = final.callPackage ./bun.nix { };
      };

      packages = forEachSystem (system: {
        default = nixpkgs.legacyPackages.${system}.callPackage ./bun.nix { };
      });
    };
}
