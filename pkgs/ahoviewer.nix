{ pkgs, source }:
pkgs.stdenv.mkDerivation {
  inherit (source) version;

  pname = "ahoviewer";

  src = pkgs.fetchzip {
    inherit (source) url sha256;
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
    gobject-introspection
    (gst_all_1.gst-plugins-good.override { gtkSupport = true; })
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
  ];

  nativeBuildInputs = with pkgs; [
    pkg-config
    wrapGAppsHook4
  ];

  # Plugins need the girepository-1.0 API, which libpeas no longer uses, and
  # this package never installed their typelibs, so build without them.
  configurePhase = "meson setup build --buildtype=release -Dlibpeas=disabled";

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
