{
  fetchurl,
  lib,
  buildGoModule,
  fetchFromGitHub,
  installShellFiles,
  stdenv,
  shadow,
  util-linux,
}:
import
  (fetchurl {
    # <https://github.com/NixOS/nixpkgs/pull/347046>
    url = "https://github.com/NixOS/nixpkgs/raw/f492564639d6f63ecbe213fe160c30e355b4fd12/pkgs/by-name/li/lilipod/package.nix";
    hash = "sha256-ojsiTyvzhDCao5USngg05e2ZEgyn8MyL/vMrrFUlEMw=";
  })
  {
    inherit
      lib
      buildGoModule
      fetchFromGitHub
      installShellFiles
      stdenv
      shadow
      util-linux
      ;
  }
