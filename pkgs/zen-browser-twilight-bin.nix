{ pkgs, self }:
import "${self}/lib/zen-browser-bin.nix" {
  version = "twilight";
  hash = "sha256-MAUJpJE3rqBcDAJqKwM8gCaRuAft32OvC75DSdctDHU=";
} { inherit pkgs; }
