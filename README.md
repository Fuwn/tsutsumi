# 📦 Tsutsumi

> Top-level Flake for Applications and Libraries Packaged for Nix

Test out any of these applications without installing anything permanently by
running `nix run github:Fuwn/tsutsumi#rui`. (or any other package in place of
`rui`)

## Applications

- [bollux](https://tildegit.org/acdw/bollux) - Command-line Gemini browser
  written in Bash
- [cynic-cli](https://github.com/obmarg/cynic/tree/main/cynic-cli) - CLI for
  Cynic, the code first GraphQL client for Rust
- [peerflix](https://github.com/mafintosh/peerflix) - Command-line streaming
  BitTorrent client
- [wakatime-ls](https://github.com/wakatime/zed-wakatime/tree/master/wakatime-ls)
  \- Language server for [Wakatime](https://wakatime.com/)
- [ahoviewer](https://github.com/ahodesuka/ahoviewer) - GTK image viewer,
  manga reader, and booru browser
- [BindToInterface](https://github.com/JsBergbau/BindToInterface)
  (`bindtointerface`) - Bind applications to a specific network
  interface/network adapter
- [cargo-clean-all](https://github.com/dnlmlr/cargo-clean-all) - Recursively
  clean all Cargo projects in a given directory that match the specified criteria
- [chan-downloader](https://github.com/nixports/chan-downloader) - CLI to
  download all images/webms in a 4chan thread
- [code-stats-ls](https://github.com/maxdeviant/code-stats-ls) - Language
  server for Code::Stats
- [gigi](https://github.com/Fuwn/gigi/) - Finger protocol server
- [git-sumi](https://github.com/welpo/git-sumi) - Non-opinionated Rust-based
  commit message linter
- [Maple](https://github.com/gemrest/maple) - Static Gemini server with Titan support
- [Mayu](https://github.com/Fuwn/mayu) - Moe-Counter compatible website hit
  counter written in Gleam
- [html2md](https://github.com/suntong/html2md) - Command-line HTML to Markdown converter
- [Private Internet Access](https://www.privateinternetaccess.com/)
  (`private-internet-access`) - Private Internet Access VPN binaries and
  configuration files
- [Rui](https://github.com/Fuwn/rui/) (`rui`) - Personal NixOS flake manager
- [`suzuri`](https://github.com/Fuwn/suzuri) - Command-line interface to [sumi.news](https://sumi.news)
- [swaddle](https://github.com/ATTron/swaddle) - `swayidle` inhibitor when
  watching content or listening to audio
- [t](https://github.com/nixports/t) - Command-line TODO list manager for
  people that want to finish tasks, not organize them
- [Thorium](https://thorium.rocks/) (`thorium`) - Fast and secure browser that
  uses modern CPU flags and LLVM optimizations
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

## Credits

This flake includes a modified version of
[`zen-browser-bin`](https://github.com/MordragT/nixos/blob/master/pkgs/by-name/zen-browser-bin/default.nix)
from [MordragT/nixos](https://github.com/MordragT/nixos), which is licensed
under the [MIT License](https://github.com/MordragT/nixos/blob/master/license).

## Licence

This project is licensed with the [GNU General Public License v3.0](./LICENSE.txt).
