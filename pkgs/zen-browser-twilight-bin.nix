{ pkgs, self }:
import "${self}/lib/zen-browser-bin.nix" {
  version = "twilight";
  hash = "sha256-ATaq5InnBdQ3C8jdqdGNQ/RwJtpmbE5kPluVUQUjkJM=";
} { inherit pkgs; }
