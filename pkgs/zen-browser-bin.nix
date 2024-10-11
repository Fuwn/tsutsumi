{
  pkgs,
  self,
  yae,
}:
import "${self}/lib/zen-browser-bin.nix" {
  inherit (yae.zen-browser-bin) sha256;

  version = "1.0.1-a.7";
} { inherit pkgs; }
