{
  lib,
  pkgs,
}:
pkgs.buildRustPackage (
  with lib;
  {
    pname = "cargo-clean-all";
    version = "21b0d4a451629f1f9073dbab8b32a6de85b33f75";
    githubOwner = "dnlmlr";
    githubHash = "sha256-rNwAzpBUAFDt6SpVi1htAMTB7TUD4YqpxJkd3hYCPAQ=";
    cargoHash = "sha256-HeA+zDdVzTFxj2EAek0dpRQ+jTOnQuRTs80ID/GtYgc=";
    license = licenses.mit;
    maintainers = [ maintainers.Fuwn ];
  }
)
