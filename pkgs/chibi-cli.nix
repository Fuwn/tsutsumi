{
  buildGo123Module,
  fetchFromGitHub,
  source,
}:
buildGo123Module rec {
  pname = "chibi";
  version = source.version;
  vendorHash = "sha256-rcOsydbD+pTS7ZWPA99P8zwJvgO/7ro1KsNPPX3PluE=";
  doCheck = false;

  src = fetchFromGitHub {
    owner = "CosmicPredator";
    repo = "${pname}-cli";
    rev = source.version;
    hash = source.hash;
  };

  postPatch = ''
    sed -i '3s/1\...\../1\.23\.0/' go.mod
  '';

  ldflags = [
    "-s"
    "-w"
    "-extldflags=-static"
    "-X main.Version=${version}"
    "-X main.Commit=${version}"
  ];
}
