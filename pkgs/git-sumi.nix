{
  lib,
  pkgs,
}:
pkgs.buildRustPackage (
  with lib;
  {
    pname = "git-sumi";
    version = "3822ce390a2a04eec4513f83586f775e59f3cbf1";
    githubOwner = "welpo";
    githubHash = "sha256-s8ZeO1vprQG8POimfZqLDbfZoG2ww1plr+V5ob59kik=";
    cargoHash = "sha256-IF6X0NZ39NalewSmQRqR38ucDhCSm57C/5I9qvX+j5A=";
    description = "The non-opinionated Rust-based commit message linter.";
    license = licenses.asl20;
    maintainers = [ maintainers.Fuwn ];
  }
)
