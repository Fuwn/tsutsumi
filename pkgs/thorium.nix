{
  pkgs,
  lib,
  yae,
}:
pkgs.appimageTools.wrapType2 {
  inherit (yae.thorium) version;

  pname = "thorium";

  src = pkgs.fetchurl {
    inherit (yae.thorium) url sha256;
  };

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
