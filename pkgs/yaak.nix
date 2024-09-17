{
  pkgs,
  lib,
}:
let
  yaak-version = "2024.6.6";

  yaak-archive = pkgs.fetchzip {
    url = "https://releases.yaak.app/releases/${yaak-version}/yaak_${yaak-version}_amd64.AppImage.tar.gz";
    hash = "sha256-Qnc4RlQmQWHARreQ69jAshq57bZ56Yt5a35jpTjGwNU=";
  };
in
pkgs.appimageTools.wrapType2 {
  pname = "yaak";
  version = yaak-version;
  src = "${yaak-archive}/yaak_${yaak-version}_amd64.AppImage";

  meta = with lib; {
    description = "The API client for modern developers";
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    homepage = "https://yaak.app/";
    license = licenses.unfree;
    platforms = platforms.linux;
    mainProgram = "yaak";
    maintainers = [ maintainers.Fuwn ];
  };
}
