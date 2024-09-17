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
    version = "e418e909ab90c8700d51b08e170051804a6919d2";
    githubOwner = "nixports";
    githubHash = "sha256-x0pKdaQFPXbdK7BjzZNA9Bq1RL2+ipe8DWav9fbLDp4=";
    cargoHash = "sha256-G0vcigHj83d9j6qMc23NTzdFMrFsNNSYBhHZYyAJhYo=";
    description = "CLI to download all images/webms in a 4chan thread";
    license = licenses.mit;
    maintainers = [ maintainers.Fuwn ];
    nativeBuildInputs = [ pkg-config ];
    buildInputs = [ openssl.dev ];
  }
)
