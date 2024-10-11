{
  pkgs,
  self,
  yae,
}:
import "${self}/lib/zen-browser-bin.nix" {
  inherit (yae.zen-browser-twilight-bin) sha256;

  version = "twilight";
} { inherit pkgs; }
