{
  lib,
  pkgs,
}:
pkgs.buildRustPackage (
  with lib;
  {
    pname = "t";
    version = "e3ed743";
    githubOwner = "juev";
    githubHash = "sha256-4xlo+WecV0wAHaHRN37HvEaKnUHIRBSMk6BWn7PAIPc=";
    cargoHash = "sha256-fz3cWgs8aqWkkOOItedWJE7OJnpO05+iSJYtj/yaqvc=";
    maintainers = [ maintainers.Fuwn ];
    license = licenses.mit;
  }
)
