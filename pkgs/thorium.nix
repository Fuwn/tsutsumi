{ pkgs, lib }:
let
  thorium-version = "126.0.6478.246";
  thorium-release = "${thorium-version}_Th24_SSE4";

  thorium-archive = pkgs.fetchurl {
    url = "https://github.com/Alex313031/thorium/releases/download/M${thorium-version}/Thorium_Browser_${thorium-release}.AppImage";
    hash = "sha256-izYbx/mSA+l7fAh917SauHopk3UlUJo+7NjkyIGpnNA=";
  };
in
pkgs.appimageTools.wrapType2 {
  pname = "thorium";
  version = thorium-version;
  src = "${thorium-archive}";

  meta = with lib; {
    description = "Chromium fork named after radioactive element No. 90.";
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    homepage = "https://thorium.rocks/";
    license = licenses.bsd3;
    platforms = platforms.linux;
    mainProgram = "thorium-browser";
    maintainers = [ maintainers.Fuwn ];
  };
}
