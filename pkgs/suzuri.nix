{
  stdenvNoCC,
  fetchFromGitHub,
  lib,
  pkgs,
  html2md,
}:
let
  owner = "Fuwn";
in
stdenvNoCC.mkDerivation rec {
  pname = "suzuri";
  version = "3b0de76";

  src = fetchFromGitHub {
    inherit owner;

    repo = pname;
    rev = "3b0de76c51e88b7be70c85e1dffc2346aa5e1303";
    hash = "sha256-t+9DW2nLEIJyVnF/gpvBnSL+l59t+TQ7z0irfrYV5Yw=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp ${pname} $out/bin
  '';

  patchPhase = with pkgs; ''
    sed -i 's|pup|${pup}/bin/pup|g' ${pname}
    sed -i 's|glow|${glow}/bin/glow|g' ${pname}
    sed -i 's|html2md|${html2md}/bin/html2md|g' ${pname}
    sed -i "s|'curl'|'${curl}/bin/curl'|g" ${pname}
  '';

  meta = with lib; {
    description = "Command-line Interface to sumi.news";
    homepage = "https://github.com/${owner}/${pname}";
    license = licenses.gpl3Only;
    platforms = platforms.unix;
    mainProgram = pname;
    maintainers = [ maintainers.Fuwn ];
  };
}
