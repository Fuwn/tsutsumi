{ pkgs, self }:
import "${self}/lib/zen-browser-bin.nix" {
  version = "1.0.1-a.7";
  hash = "sha256-0EYfH8hFStQMpxn5YZ/EP4vX8sn4bGmWobpZgygTi7Y=";
} { inherit pkgs; }
