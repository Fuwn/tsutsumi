{
  buildGo123Module,
  fetchFromGitHub,
  source,
}:
buildGo123Module rec {
  pname = "chibi";
  version = source.version;
  vendorHash = "sha256-nSEGkn6fhr0++9uzh/+7JHUwbj879fhs0zV2/i1AEYU=";
  doCheck = false;

  src = fetchFromGitHub {
    owner = "CosmicPredator";
    repo = pname;
    rev = source.version;
    hash = source.hash;
  };

  postPatch = ''
    sed -i '3s/1.23.4/1.23.3/' go.mod
    cp ${./go.sum} ./go.sum
  '';

  ldflags = [
    "-s"
    "-w"
    "-extldflags=-static"
    "-X main.Version=${version}"
    "-X main.Commit=${version}"
  ];
}
