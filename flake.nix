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
              inherit (yae.${name}) url hash;
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

        nixCheckTools = [
          pkgs.deadnix
          pkgs.nixfmt
          pkgs.statix
        ];
      in
      {
        packages = {
          bollux = pkgs.callPackage ./pkgs/bollux { };
          chibi = pkgs.callPackage ./pkgs/chibi-cli.nix { inherit yae; };
          cynic-cli = pkgs.callPackage ./pkgs/cynic-cli { };
          peerflix = pkgs.callPackage ./pkgs/peerflix { source = yae.peerflix; };
          wakatime-ls = pkgs.callPackage ./pkgs/wakatime-ls { };
          ahoviewer = pkgs.callPackage ./pkgs/ahoviewer.nix { source = yae.ahoviewer; };
          bindtointerface = pkgs.callPackage ./pkgs/bindtointerface.nix { };
          cargo-clean-all = pkgs.callPackage ./pkgs/cargo-clean-all.nix { };
          chan-downloader = pkgs.callPackage ./pkgs/chan-downloader { };
          code-stats-ls = pkgs.callPackage ./pkgs/code-stats-ls.nix { };
          gigi = gigi.packages.${system}.default;
          git-sumi = pkgs.callPackage ./pkgs/git-sumi.nix { };
          maple = yaePackage "maple";
          # mayu = yaePackage "mayu";
          html2md = pkgs.callPackage ./pkgs/html2md { };
          lilipod = pkgs.callPackage ./pkgs/lilipod.nix { };
          parse-ripper-output = pkgs.callPackage ./pkgs/parse-ripper-output.nix { source = yae.ripper; };
          private-internet-access = pkgs.callPackage ./pkgs/private-internet-access.nix { };
          rui = yaePackage "rui";
          ripper = pkgs.callPackage ./pkgs/ripper.nix { source = yae.ripper; };
          swaddle = pkgs.callPackage ./pkgs/swaddle.nix { };
          t = pkgs.callPackage ./pkgs/t { };
          thorium = pkgs.callPackage ./pkgs/thorium.nix { inherit yae; };
          yae = yaePackage "yae";
          yaak = pkgs.callPackage ./pkgs/yaak.nix { inherit yae; };
          # zen-browser-bin = pkgs.callPackage ./pkgs/zen-browser-bin.nix { inherit pkgs self yae; };

          # zen-browser-twilight-bin = pkgs.callPackage ./pkgs/zen-browser-twilight-bin.nix {
          #   inherit pkgs self yae;
          # };
        };

        formatter = nixpkgs.legacyPackages."${system}".nixfmt-rfc-style;

        checks.nix = pkgs.runCommand "tsutsumi-nix-check" { nativeBuildInputs = nixCheckTools; } ''
          cd ${self}
          deadnix --fail .
          nixfmt --check $(find . -name '*.nix')
          statix check .
          touch "$out"
        '';

        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.just
            self.packages.${system}.yae
          ]
          ++ nixCheckTools;
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

    # Rui's flake requires this input, and yaePackage passes it through.
    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";

      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
    };
  };
}
