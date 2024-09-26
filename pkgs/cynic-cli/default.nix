{
  lib,
  pkg-config,
  openssl,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "cynic-cli";
  version = "3.8.0";
  cargoLock.lockFile = ./Cargo.lock;
  postPatch = "ln -s ${./Cargo.lock} Cargo.lock";
  cargoPatches = [ ./fix-cargo-toml.patch ];
  doCheck = false;
  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl.dev ];

  src = "${
    fetchFromGitHub {
      owner = "obmarg";
      repo = "cynic";
      rev = "c91f2f33a24909c9893fab256df3c6cfd6f3bfde";
      hash = "sha256-PlZGekwSSyRJEGQ2s5RK6xCoJDmmEZmec8a6pe0DXJk=";
    }
  }/cynic-cli";

  meta = with lib; {
    homepage = "https://github.com/obmarg/cynic/tree/main/cynic-cli";
    mainProgram = "cynic";
    license = licenses.mpl20;
    maintainers = [ maintainers.Fuwn ];
    description = "A CLI for Cynic, the code first GraphQL client for Rust";
  };
}
