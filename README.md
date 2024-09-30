# 📦 Tsutsumi

> Top-level Flake for Applications and Libraries Packaged for Nix

Test out any of these applications without installing anything permanently by
running `nix run github:Fuwn/tsutsumi#rui`. (or any other package in place of
`rui`)

## Applications

- [bollux](https://tildegit.org/acdw/bollux) - a Gemini browser in like, idk,
  96% pure Bash
- [cynic-cli](https://github.com/obmarg/cynic/tree/main/cynic-cli) - A CLI for
  Cynic, the code first GraphQL client for Rust
- [wakatime-ls](https://github.com/wakatime/zed-wakatime/tree/master/wakatime-ls)
  \- A language server for [Wakatime](https://wakatime.com/).
- [Zen Browser](https://zen-browser.app/) (`zen-browser-bin`)
- [ahoviewer](https://github.com/ahodesuka/ahoviewer) - A GTK image viewer,
  manga reader, and booru browser
- [BindToInterface](https://github.com/JsBergbau/BindToInterface)
  (`bindtointerface`) - With this program you can bind applications to a
  specific network interface / network adapter.
- [cargo-clean-all](https://github.com/dnlmlr/cargo-clean-all)
- [chan-downloader](https://github.com/nixports/chan-downloader) - CLI to
  download all images/webms in a 4chan thread
- [code-stats-ls](https://github.com/maxdeviant/code-stats-ls) - A language
  server for Code::Stats
- [gigi](https://github.com/Fuwn/gigi/) - An honest Finger protocol server
- [git-sumi](https://github.com/welpo/git-sumi) - The non-opinionated Rust-based
  commit message linter.
- [Maple](https://github.com/gemrest/maple) - A very simple static Gemini
  server, now with Titan support!
- [Mayu](https://github.com/Fuwn/mayu) - Moe-Counter Compatible Website Hit
  Counter Written in Gleam
- [Private Internet Access](https://www.privateinternetaccess.com/)
  (`private-internet-access`) - Private Internet Access: The Best VPN for
  Digital Privacy
- [Rui](https://github.com/Fuwn/rui/) (`rui`) - Personal NixOS Flake Manager
- [swaddle](https://github.com/ATTron/swaddle) - Swayidle inhibitor when
  watching content or listening to audio
- [t](https://github.com/nixports/t) - A command-line todo list manager for
  people that want to finish tasks, not organize them.
- [Thorium](https://thorium.rocks/) (`thorium`) - Chromium fork named after
  radioactive element No. 90.
- [Yaak](https://yaak.app/) (`yaak`) - The API client for modern developers

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
tsutsumi.packages.${pkgs.system}.rui # Or any other package

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

## Credits

This flake includes a modified version of
[`zen-browser-bin`](https://github.com/MordragT/nixos/blob/master/pkgs/by-name/zen-browser-bin/default.nix)
from [MordragT/nixos](https://github.com/MordragT/nixos), which is licensed
under the [MIT License](https://github.com/MordragT/nixos/blob/master/license).

## Licence

This project is licensed with the [GNU General Public License v3.0](./LICENSE.txt).
