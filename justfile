check:
  NIXPKGS_ALLOW_UNFREE=1 nix flake check --impure

build package:
  NIXPKGS_ALLOW_UNFREE=1 nix build .#{{package}} --impure

run package:
  NIXPKGS_ALLOW_UNFREE=1 nix run .#{{package}} --impure

sort-packages:
  ls -la pkgs/ | awk '{sub(/\.nix$/, "", $9); print $9}' | sort
