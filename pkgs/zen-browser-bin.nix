{
  pkgs,
  self,
  yae,
}:
import "${self}/lib/zen-browser-bin.nix" {
  name = "zen-browser-bin";
  source = yae.zen-browser-bin;
} { inherit pkgs; }
