{ pkgs, lib }:
pkgs.stdenvNoCC.mkDerivation {
  pname = "bollux";
  version = "0.4.1";
  nativeBuildInputs = [ pkgs.makeWrapper ];
  buildInputs = [ pkgs.bashInteractive ];
  dontBuild = true;
  makeFlags = [ "PREFIX=$(out)" ];

  src = pkgs.fetchFromGitea {
    domain = "tildegit.org";
    owner = "acdw";
    repo = "bollux";
    rev = "f472e60f1164f0dc025d06db2a13ff4e8ebee1a2";
    hash = "sha256-mo2qWCPfW+dUaYcJLsos/vR5nJ8n1eABy8Zy8OZsfVg=";
  };

  patches = [
    # https://tildegit.org/acdw/bollux/issues/13#issuecomment-9786
    ./fix_lesskey_nag.patch
  ];

  postInstall = ''
    wrapProgram $out/bin/bollux --prefix PATH : ${
      lib.makeBinPath [
        pkgs.bashInteractive
        pkgs.iconv
        pkgs.openssl
        pkgs.less
        pkgs.coreutils
      ]
    }
  '';

  meta = with lib; {
    description = "a Gemini browser in like, idk, 96% pure Bash";
    homepage = "https://tildegit.org/acdw/bollux";
    license = licenses.mit;
    platforms = platforms.all;
    mainProgram = "bollux";
    maintainers = [ maintainers.Fuwn ];
  };
}
