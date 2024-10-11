{
  description = "Top-level Flake for Applications and Libraries Packaged for Nix";

  nixConfig = {
    extra-substituters = [ "https://tsutsumi.cachix.org" ];

    trusted-public-keys = [
      "tsutsumi.cachix.org-1:MojIlGI60CT5EoyuTgjB4VRVgf/uUvakZVWoYJThQNk="
    ];
  };

  outputs =
    {
      flake-utils,
      gigi,
      maple,
      mayu,
      nixpkgs,
      pre-commit-hooks,
      rui,
      self,
      ...
    }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;

          config.allowUnfreePredicate =
            pkg:
            builtins.elem (pkgs.lib.getName pkg) [
              "private-internet-access"
              "yaak"
            ];

          overlays = [
            (final: _: {
              buildRustPackage = import ./lib/build-rust-package.nix {
                inherit (final) lib rustPlatform fetchFromGitHub;
              };
            })
          ];
        };

        yae = builtins.fromJSON (builtins.readFile "${self}/yae.json");
      in
      {
        packages = {
          bollux = pkgs.callPackage ./pkgs/bollux { };
          cynic-cli = pkgs.callPackage ./pkgs/cynic-cli { };
          peerflix = pkgs.callPackage ./pkgs/peerflix { };
          wakatime-ls = pkgs.callPackage ./pkgs/wakatime-ls { };
          ahoviewer = pkgs.callPackage ./pkgs/t.nix { };
          bindtointerface = pkgs.callPackage ./pkgs/bindtointerface.nix { };
          cargo-clean-all = pkgs.callPackage ./pkgs/cargo-clean-all.nix { };
          chan-downloader = pkgs.callPackage ./pkgs/chan-downloader.nix { };
          code-stats-ls = pkgs.callPackage ./pkgs/code-stats-ls.nix { };
          gigi = gigi.packages.${system}.default;
          git-sumi = pkgs.callPackage ./pkgs/git-sumi.nix { };
          maple = maple.packages.${system}.default;
          mayu = mayu.packages.${system}.default;
          html2md = pkgs.callPackage ./pkgs/html2md.nix { };
          lilipod = pkgs.callPackage ./pkgs/lilipod.nix { };
          private-internet-access = pkgs.callPackage ./pkgs/private-internet-access.nix { };
          rui = rui.packages.${system}.default;
          suzuri = pkgs.callPackage ./pkgs/suzuri.nix { inherit (self.packages.${system}) html2md; };
          swaddle = pkgs.callPackage ./pkgs/swaddle.nix { };
          t = pkgs.callPackage ./pkgs/t.nix { };
          thorium = pkgs.callPackage ./pkgs/thorium.nix { inherit yae; };
          yae = inputs.yae.packages.${system}.default;
          yaak = pkgs.callPackage ./pkgs/yaak.nix { inherit yae; };
          zen-browser-bin = pkgs.callPackage ./pkgs/zen-browser-bin.nix { inherit pkgs self yae; };

          zen-browser-twilight-bin = pkgs.callPackage ./pkgs/zen-browser-twilight-bin.nix {
            inherit pkgs self yae;
          };
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

    gigi = {
      url = "github:Fuwn/gigi";

      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };

    maple = {
      url = "github:gemrest/maple";

      inputs = {
        flake-compat.follows = "flake-compat";
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };

    mayu = {
      url = "github:Fuwn/mayu";

      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };

    yae = {
      url = "github:Fuwn/yae";

      inputs = {
        flake-compat.follows = "flake-compat";
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
        pre-commit-hooks.follows = "pre-commit-hooks";
        systems.follows = "systems";
      };
    };
  };
}
