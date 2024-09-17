# 📦 Tsutsumi

> Top-level Flake for Applications and Libraries Packaged for Nix

## Applications

- [bollux](https://tildegit.org/acdw/bollux) - a Gemini browser in like, idk, 96% pure Bash
- [ahoviewer](https://github.com/ahodesuka/ahoviewer) - A GTK image viewer, manga reader, and booru browser
- [BindToInterface](https://github.com/JsBergbau/BindToInterface) - With this program you can bind applications to a specific network interface / network adapter.
- [cargo-clean-all](https://github.com/dnlmlr/cargo-clean-all)
- [chan-downloader](https://github.com/nixports/chan-downloader) - CLI to download all images/webms in a 4chan thread
- [git-sumi](https://github.com/welpo/git-sumi) - The non-opinionated Rust-based commit message linter.
- [Private Internet Access](https://www.privateinternetaccess.com/) - Private Internet Access: The Best VPN for Digital Privacy
- [swaddle](https://github.com/ATTron/swaddle) - Swayidle inhibitor when watching content or listening to audio
- [t](https://github.com/nixports/t) - A command-line todo list manager for people that want to finish tasks, not organize them.
- [Thorium](https://thorium.rocks/) - Chromium fork named after radioactive element No. 90. Windows and MacOS/Raspi/Android/Special builds are in different repositories, links are towards the top of the README.md."
- [Yaak](https://yaak.app/) - The API client for modern developers
- [Zen Browser](https://zen-browser.app/)

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
