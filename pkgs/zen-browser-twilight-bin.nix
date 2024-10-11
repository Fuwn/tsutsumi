{
  pkgs,
  self,
  yae,
}:
import "${self}/lib/zen-browser-bin.nix" {
  inherit (yae.zen-browser-bin) sha256 version;
} { inherit pkgs; }
