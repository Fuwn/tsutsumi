{
  pkgs,
  self,
  yae,
}:
import "${self}/lib/zen-browser-bin.nix" {
  name = "zen-browser-twilight-bin";
  source = yae.zen-browser-twilight-bin;
} { inherit pkgs; }
