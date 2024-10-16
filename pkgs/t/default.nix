{
  lib,
  pkgs,
}:
pkgs.buildRustPackage (
  with lib;
  {
    pname = "t";
    version = "e3ed743183ac8fb95e3ba22af4669d06e6860691";
    githubOwner = "juev";
    githubHash = "sha256-lwnUj2SLN4ktpywozLF+rlw4flCM1io39FtEaAR4u3Q=";
    maintainers = [ maintainers.Fuwn ];
    license = licenses.mit;
    cargoLock.lockFile = ./Cargo.lock;
    postPatch = "ln -s ${./Cargo.lock} Cargo.lock";
  }
)
