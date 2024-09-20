{
  lib,
  pkgs,
}:
pkgs.rustPlatform.buildRustPackage rec {
  pname = "wakatime-ls";
  version = "73ac872be7ebd87df3c409078f1867e1972ce9cb";
  cargoLock.lockFile = ./Cargo.lock;
  postPatch = "ln -s ${./Cargo.lock} Cargo.lock";
  cargoPatches = [ ./fix-version.patch ];
  doCheck = false;

  src = "${
    pkgs.fetchFromGitHub {
      owner = "wakatime";
      repo = "zed-wakatime";
      rev = version;
      hash = "sha256-xWCo1+4LZD0L5ZF8wYHQkAOHj2abyFeGUlVPU8yEJ2Q=";
    }
  }/wakatime-ls";

  meta = with lib; {
    homepage = "https://github.com/wakatime/zed-wakatime/tree/master/wakatime-ls";
    mainProgram = pname;
    license = licenses.mit;
    maintainers = [ maintainers.Fuwn ];
    description = "A language server for Wakatime.";
  };
}
