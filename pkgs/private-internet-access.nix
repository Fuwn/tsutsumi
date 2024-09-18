{
  pkgs,
  stdenvNoCC,
  autoPatchelfHook,
  lib,
}:
stdenvNoCC.mkDerivation rec {
  pname = "private-internet-access";
  version = "3.6.1";
  unpackPhase = "true";

  nativeBuildInputs = [
    autoPatchelfHook
    pkgs.qt5.wrapQtAppsHook
  ];

  src = pkgs.fetchurl {
    url = "https://installers.privateinternetaccess.com/download/pia-linux-${version}-08339.run";
    hash = "sha256-bxTGPHt/vF50guovtCOBr63m3IvPmBZjKBOt+hEsphM=";
  };

  buildInputs = with pkgs; [
    qt6.full
    libcap_ng
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/pia

    bash $src --noexec --target $out/pia
    rm $out/pia/piafiles/bin/pia-unbound

    mkdir -p $out/bin
    cp -r $out/pia/piafiles/bin/* $out/bin/

    mkdir -p $out/lib
    cp -r $out/pia/piafiles/lib/* $out/lib/

    mkdir -p $out/share
    cp -r $out/pia/piafiles/share/* $out/share/

    mkdir -p $out/plugins
    cp -r $out/pia/piafiles/plugins/* $out/plugins/

    mkdir -p $out/qml
    cp -r $out/pia/piafiles/qml/* $out/qml/

    mkdir -p $out/etc/systemd/system/
    cp $out/pia/installfiles/piavpn.service $out/etc/systemd/system/
    cp $out/pia/installfiles/piavpn.openrc.service $out/etc/systemd/system/
    cp $out/pia/installfiles/piavpn.sysvinit.service $out/etc/systemd/system/

    mkdir -p $out/share/applications
    mkdir -p $out/share/icons/hicolor/256x256/apps
    cp $out/pia/installfiles/piavpn.desktop $out/share/applications/
    cp $out/pia/installfiles/app-icon.png $out/share/icons/hicolor/256x256/apps/

    runHook postInstall
  '';

  meta = with lib; {
    description = "Private Internet Access: The Best VPN for Digital Privacy";
    license = licenses.unfree;
    platforms = platforms.linux;
    maintainers = [ maintainers.Fuwn ];
    homepage = "https://www.privateinternetaccess.com/";
  };
}
