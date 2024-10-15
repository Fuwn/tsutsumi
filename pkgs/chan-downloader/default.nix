{
  lib,
  pkg-config,
  openssl,
  pkgs,
}:
pkgs.buildRustPackage (
  with lib;
  {
    pname = "chan-downloader";
    version = "be4617f";
    githubOwner = "mariot";
    githubHash = "sha256-gD6jiSk1RnlgnomhhbajUBq8SQT46u9j8VnkE/IuXqk=";
    description = "CLI to download all images/webms in a 4chan thread";
    license = licenses.mit;
    maintainers = [ maintainers.Fuwn ];
    nativeBuildInputs = [ pkg-config ];
    buildInputs = [ openssl.dev ];
    cargoLock.lockFile = ./Cargo.lock;
    postPatch = "ln -s ${./Cargo.lock} Cargo.lock";
  }
)
