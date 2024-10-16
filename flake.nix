{
  description = "Top-level Flake for Applications and Libraries Packaged for Nix";

  nixConfig = {
    extra-substituters = [ "https://tsutsumi.cachix.org" ];

    extra-trusted-public-keys = [
      "tsutsumi.cachix.org-1:MojIlGI60CT5EoyuTgjB4VRVgf/uUvakZVWoYJThQNk="
    ];
  };

  outputs =
    {
      flake-utils,
      gigi,
      gitignore,
      nix-gleam,
      nixpkgs,
      pre-commit-hooks,
      self,
      ...
    }:
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

        yaePackage =
          name:
          let
            archive = pkgs.fetchzip {
              inherit (yae.${name}) url sha256;
            };
          in
          ((import "${archive}/flake.nix").outputs {
            inherit
              flake-utils
              gitignore
              nix-gleam
              nixpkgs
              pre-commit-hooks
              ;

            self = archive;
          }).packages.${system}.default;
      in
      {
        packages = {
          bollux = pkgs.callPackage ./pkgs/bollux { };
          cynic-cli = pkgs.callPackage ./pkgs/cynic-cli { };
          peerflix = pkgs.callPackage ./pkgs/peerflix { };
          wakatime-ls = pkgs.callPackage ./pkgs/wakatime-ls { };
          ahoviewer = pkgs.callPackage ./pkgs/ahoviewer.nix { };
          bindtointerface = pkgs.callPackage ./pkgs/bindtointerface.nix { };
          cargo-clean-all = pkgs.callPackage ./pkgs/cargo-clean-all.nix { };
          chan-downloader = pkgs.callPackage ./pkgs/chan-downloader { };
          code-stats-ls = pkgs.callPackage ./pkgs/code-stats-ls.nix { };
          gigi = gigi.packages.${system}.default;
          git-sumi = pkgs.callPackage ./pkgs/git-sumi.nix { };
          maple = yaePackage "maple";
          mayu = yaePackage "mayu";
          html2md = pkgs.callPackage ./pkgs/html2md.nix { };
          lilipod = pkgs.callPackage ./pkgs/lilipod.nix { };
          private-internet-access = pkgs.callPackage ./pkgs/private-internet-access.nix { };
          rui = yaePackage "rui";
          suzuri = pkgs.callPackage ./pkgs/suzuri.nix { inherit (self.packages.${system}) html2md; };
          swaddle = pkgs.callPackage ./pkgs/swaddle.nix { };
          t = pkgs.callPackage ./pkgs/t { };
          thorium = pkgs.callPackage ./pkgs/thorium.nix { inherit yae; };
          yae = yaePackage "yae";
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

          buildInputs = [
            pkgs.just
            self.packages.${system}.yae
          ] ++ self.checks.${system}.pre-commit-check.enabledPackages;
        };
      }
    );

  inputs = {
    nix-gleam.url = "github:arnarg/nix-gleam";
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

    gigi = {
      url = "github:Fuwn/gigi";

      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };

    gitignore = {
      url = "github:hercules-ci/gitignore.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";

      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
    };
  };
}
