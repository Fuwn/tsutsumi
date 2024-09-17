{
  lib,
  dbus,
  pkg-config,
  pkgs,
}:
pkgs.buildRustPackage (
  with lib;
  {
    pname = "swaddle";
    version = "5a91352b3fc84d3af5d82eeda90f4b6844126dcb";
    githubOwner = "ATTron";
    githubHash = "sha256-tZAmaHXatzAo+sF2eBO2xsvJX2G2h6ShFRFpCHJcVew=";
    cargoHash = "sha256-q+EkvenuJGxmfDpPnvQa3lJSc+CUCFxesmDaVGbBngE=";
    description = "Swayidle inhibitor when watching content or listening to audio";
    license = licenses.mit;
    maintainers = [ maintainers.Fuwn ];
    nativeBuildInputs = [ pkg-config ];
    buildInputs = [ dbus.dev ];
  }
)
