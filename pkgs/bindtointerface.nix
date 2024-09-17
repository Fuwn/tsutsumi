{
  pkgs,
  lib,
  stdenv,
  gcc,
}:
stdenv.mkDerivation {
  pname = "bindtointerface";
  version = "1.0";
  nativeBuildInputs = [ gcc ];

  src = pkgs.fetchFromGitHub {
    owner = "JsBergbau";
    repo = "BindToInterface";
    rev = "d477326d85f64fdd1dc46382fe698e46f4843100";
    hash = "sha256-B29nXjy8RyFEOsYtko8l9i38sDauX2eW+pLsQssNTmQ=";
  };

  buildPhase = ''
    gcc \
      -nostartfiles \
      -fpic \
      -shared $src/bindToInterface.c \
      -o bindToInterface.so \
      -ldl \
      -D_GNU_SOURCE
  '';

  installPhase = ''
    mkdir -p $out/bin $out/lib
    cp bindToInterface.so $out/lib

    cat <<EOF > $out/bin/vpn
    #!/usr/bin/env bash

    env LD_PRELOAD=$out/lib/bindToInterface.so "\$@"
    EOF
    chmod +x $out/bin/vpn
  '';

  meta = with lib; {
    description = "With this program you can bind applications to a specific network interface / network adapter.";
    homepage = "https://github.com/JsBergbau/BindToInterface";
    license = licenses.gpl2;
    maintainers = [ maintainers.Fuwn ];
    platforms = platforms.linux;
  };
}
