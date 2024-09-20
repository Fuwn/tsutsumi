{
  lib,
  pkg-config,
  openssl,
  pkgs,
}:
pkgs.buildRustPackage (
  with lib;
  {
    pname = "code-stats-ls";
    version = "9cae08e121eece2f379d4996156c66971bab8133";
    githubOwner = "maxdeviant";
    githubHash = "sha256-/w+oqO4eHh4MEbxpSYEfoGbdWguFxg8laob3/oZDFO0=";
    cargoHash = "sha256-oyhespwCTE3/ivljj/mFgAtC4TQvswBGKP2RiD5B/wY=";
    license = licenses.mit;
    maintainers = [ maintainers.Fuwn ];
    nativeBuildInputs = [ pkg-config ];
    buildInputs = [ openssl.dev ];
  }
)
