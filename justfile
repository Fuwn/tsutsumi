check:
  NIXPKGS_ALLOW_UNFREE=1 nix flake check --impure

build package:
  NIXPKGS_ALLOW_UNFREE=1 nix build .#{{package}} --impure

run package:
  NIXPKGS_ALLOW_UNFREE=1 nix run .#{{package}} --impure

