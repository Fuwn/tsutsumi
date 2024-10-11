{
  pkgs,
  lib,
  yae,
}:
let
  inherit (yae.yaak) version;
in
pkgs.appimageTools.wrapType2 {
  inherit version;

  pname = "yaak";

  src =
    let
      unzipped-archive =
        let
          archive = pkgs.fetchurl {
            inherit (yae.yaak) url sha256;
          };
        in
        pkgs.runCommand "unzipped" { } ''
          mkdir -p $out
          tar -xvf ${archive} -C $out
        '';
    in
    "${unzipped-archive}/yaak_${version}_amd64.AppImage";

  buildInputs = [ pkgs.bzip2 ];

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
