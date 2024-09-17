{
  lib,
  pkgs,
}:
pkgs.buildRustPackage (
  with lib;
  {
    pname = "t";
    version = "30a0bf6e5aec20c40e1b0c96fe9c6e3521997ff3";
    githubOwner = "nixports";
    githubHash = "sha256-4xlo+WecV0wAHaHRN37HvEaKnUHIRBSMk6BWn7PAIPc=";
    cargoHash = "sha256-olRytgRRCj9V+V96Q1Eb+JOGxFKhhd/1C2Ge4NXv86Q=";
    maintainers = with maintainers; [ Fuwn ];
    license = licenses.mit;
  }
)
