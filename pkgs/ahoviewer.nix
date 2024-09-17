{ pkgs }:
pkgs.stdenv.mkDerivation rec {
  pname = "ahoviewer";
  version = "42e16f94b78496e3e346f0d127baa569039a6757";

  src = pkgs.fetchFromGitHub {
    owner = "ahodesuka";
    repo = pname;
    rev = "42e16f94b78496e3e346f0d127baa569039a6757";
    sha256 = "sha256-HcijKiExwyBoWDvMlJ5AMA0U7BtS9EfcA54nfQ/iGvE=";
  };

  buildInputs = with pkgs; [
    meson
    ninja
    gtkmm3
    gtk3
    libconfig
    libxml2
    curl
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    libpeas
    libsecret
    libzip
  ];

  nativeBuildInputs = [ pkgs.pkg-config ];

  configurePhase = "meson setup build --buildtype=release";

  buildPhase = ''
    cd build
    ninja
    cd ..
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp build/src/ahoviewer $out/bin
  '';

  meta = with pkgs.lib; {
    description = "A GTK image viewer, manga reader, and booru browser";
    homepage = "https://github.com/ahodesuka/ahoviewer";
    license = licenses.mit;
    maintainers = [ maintainers.Fuwn ];
    platforms = platforms.linux;
  };
}
