{ buildGoModule, fetchFromGitHub }:
buildGoModule rec {
  pname = "html2md";
  version = "b194d45";
  vendorHash = "sha256-pquwaU0UleC6Om2T6nICdU1+es9c+nTzF5Gn/9OiUkU=";
  doCheck = false;

  src = fetchFromGitHub {
    owner = "suntong";
    repo = pname;
    rev = "b194d45263a3ce8627eb93f1132ed2bc408687f6";
    hash = "sha256-HXD+D/14VUBJJDO9EVaPnTQtdXRyLV4pdemPIG5b2to=";
  };

  postPatch = ''
    cp ${./go.mod} go.mod
    cp ${./go.sum} go.sum
  '';

  ldflags = [
    "-s"
    "-w"
    "-extldflags=-static"
    "-X main.Version=${version}"
    "-X main.Commit=${version}"
  ];
}
