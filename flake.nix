{
  description = "Top-level Flake for Applications and Libraries Packaged for Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    systems.url = "github:nix-systems/default";

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";

      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
    };

    rui = {
      url = "github:Fuwn/rui";

      inputs = {
        flake-compat.follows = "flake-compat";
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
        pre-commit-hooks.follows = "pre-commit-hooks";
        systems.follows = "systems";
      };
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      pre-commit-hooks,
      rui,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;

          overlays = [
            (final: _: {
              buildRustPackage = import ./lib/build-rust-package.nix {
                inherit (final) lib rustPlatform fetchFromGitHub;
              };
            })
          ];
        };
      in
      {
        packages = {
          bollux = pkgs.callPackage ./pkgs/bollux { };
          ahoviewer = pkgs.callPackage ./pkgs/t.nix { };
          bindtointerface = pkgs.callPackage ./pkgs/bindtointerface.nix { };
          cargo-clean-all = pkgs.callPackage ./pkgs/cargo-clean-all.nix { };
          chan-downloader = pkgs.callPackage ./pkgs/chan-downloader.nix { };
          git-sumi = pkgs.callPackage ./pkgs/git-sumi.nix { };
          private-internet-access = pkgs.callPackage ./pkgs/private-internet-access.nix { };
          rui = rui.packages.${system}.default;
          swaddle = pkgs.callPackage ./pkgs/swaddle.nix { };
          t = pkgs.callPackage ./pkgs/t.nix { };
          thorium = pkgs.callPackage ./pkgs/thorium.nix { };
          yaak = pkgs.callPackage ./pkgs/yaak.nix { };
          zen-browser-bin = pkgs.callPackage ./pkgs/zen-browser-bin { };
        };

        formatter = nixpkgs.legacyPackages."${system}".nixfmt-rfc-style;

        checks.pre-commit-check = pre-commit-hooks.lib.${system}.run {
          src = ./.;

          hooks = {
            deadnix.enable = true;
            flake-checker.enable = true;
            nixfmt-rfc-style.enable = true;
            statix.enable = true;
          };
        };

        devShells.default = pkgs.mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;

          buildInputs = [ pkgs.just ] ++ self.checks.${system}.pre-commit-check.enabledPackages;
        };
      }
    );
}
