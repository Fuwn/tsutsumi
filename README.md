# 📦 Tsutsumi

> Top-level Flake for Applications and Libraries Packaged for Nix

Test out any of these applications without installing anything permanently by
running `nix run github:Fuwn/tsutsumi#rui`. (or any other package in place of
`rui`, [continued](#nix-run-with-binary-cache))

## Applications

- [Maple](https://github.com/gemrest/maple) - Static Gemini server with Titan support
- [Rui](https://github.com/Fuwn/rui/) (`rui`) - Personal NixOS flake manager
- [Yae](https://github.com/Fuwn/yae) (`yae`) - Nix Dependency Manager
- [ahoviewer](https://github.com/ahodesuka/ahoviewer) - GTK image viewer,
  manga reader, and booru browser
- [BindToInterface](https://github.com/JsBergbau/BindToInterface)
  (`bindtointerface`) - Bind applications to a specific network
  interface/network adapter
- [bollux](https://tildegit.org/acdw/bollux) - Command-line Gemini browser
  written in Bash
- [cargo-clean-all](https://github.com/dnlmlr/cargo-clean-all) - Recursively
  clean all Cargo projects in a given directory that match the specified criteria
- [chan-downloader](https://github.com/mariot/chan-downloader) - CLI to
  download all images/webms in a 4chan thread
- [code-stats-ls](https://github.com/maxdeviant/code-stats-ls) - Language
  server for Code::Stats
- [cynic-cli](https://github.com/obmarg/cynic/tree/main/cynic-cli) - CLI for
  Cynic, the code first GraphQL client for Rust
- [git-sumi](https://github.com/welpo/git-sumi) - Non-opinionated Rust-based
  commit message linter
- [gigi](https://github.com/Fuwn/gigi/) - Finger protocol server
- [html2md](https://github.com/suntong/html2md) - Command-line HTML to Markdown converter
- [Lilipod](https://github.com/89luca89/lilipod) - Simple container manager
- [peerflix](https://github.com/mafintosh/peerflix) - Command-line streaming
  BitTorrent client
- [`parse-ripper-output`](github.com/saucecode/reddit-thread-ripper) - Sister
  program to `reddit-thread-ripper` that parses the output of the latter into
  an HTML document
- [Private Internet Access](https://www.privateinternetaccess.com/)
  (`private-internet-access`) - Private Internet Access VPN binaries and
  configuration files
- [reddit-thread-ripper](github.com/saucecode/reddit-thread-ripper) - a Python
  program/library to download an entire reddit thread's comment section
- [`suzuri`](https://github.com/Fuwn/suzuri) - Command-line interface to [sumi.news](https://sumi.news)
- [swaddle](https://github.com/ATTron/swaddle) - `swayidle` inhibitor when
  watching content or listening to audio
- [t](https://github.com/juev/t) - Command-line TODO list manager for
  people that want to finish tasks, not organize them
- [Thorium](https://thorium.rocks/) (`thorium`) - Fast and secure browser that
  uses modern CPU flags and LLVM optimizations
- [wakatime-ls](https://github.com/wakatime/zed-wakatime/tree/master/wakatime-ls)
  \- Language server for [Wakatime](https://wakatime.com/)
- [Yaak](https://yaak.app/) (`yaak`) - API client for modern developers
- [Zen Browser](https://zen-browser.app/) (`zen-browser-bin`) - Firefox based
  browser with a focus on privacy and customisation (alpha release)
- [Zen Browser](https://zen-browser.app/) (`zen-browser-twilight-bin`) Firefox based
  browser with a focus on privacy and customisation (twilight release)

## Installation

### Add to Flake Inputs (for Flakes Users)

```nix
{
  inputs.tsutsumi = {
    url = "github:Fuwn/tsutsumi";
    inputs.nixpkgs.follows = "nixpkgs"; # Recommended
  };
}
```

### Add to System or Home Manager Packages

```nix
# For flakes users
inputs.tsutsumi.packages.${pkgs.system}.rui # Or any other package

# For non-flakes users
(import (
  pkgs.fetchFromGitHub {
    owner = "Fuwn";
    repo = "tsutsumi";
    rev = "...";  # Use the current commit revision hash
    hash = "..."; # Use the current commit sha256 hash
  }
)).packages.${builtins.currentSystem}.rui # Or any other package
```

### Use as a Nix Packages Overlay

Overlaying Tsutsumi allows you to simplify the mass installation of Tsutsumi
packages. For example, `inputs.tsutsumi.packages.${pkgs.system}.rui` becomes
`pkgs.tsutsumi.rui`.

```nix
import nixpkgs {
  system = "your_system_attribute";

  overlays = [
    (_: _: {
      tsutsumi = inputs.tsutsumi.packages.${system};
    })
  ];
}
```

## Binary Cache

To speed up the consumption of Tsutsumi packages, add the Tsutsumi binary cache
to your NixOS configuration.

```nix
nix.settings = {
  substituters = [ "https://tsutsumi.cachix.org" ];

  trusted-public-keys = [
    "tsutsumi.cachix.org-1:MojIlGI60CT5EoyuTgjB4VRVgf/uUvakZVWoYJThQNk="
  ];
};
```

### Nix Run With Binary Cache

Replace `rui` with any other package name made available by Tsutsumi.

```bash
nix run github:Fuwn/tsutsumi#rui \
  --extra-substituters "https://tsutsumi.cachix.org" \
  --extra-trusted-public-keys "tsutsumi.cachix.org-1:MojIlGI60CT5EoyuTgjB4VRVgf/uUvakZVWoYJThQNk="
```

## Credits

This flake includes a modified version of
[`zen-browser-bin`](https://github.com/MordragT/nixos/blob/master/pkgs/by-name/zen-browser-bin/default.nix)
from [MordragT/nixos](https://github.com/MordragT/nixos), which is licensed
under the [MIT License](https://github.com/MordragT/nixos/blob/master/license).

## Licence

This project is licensed with the [GNU General Public License v3.0](./LICENSE.txt).
