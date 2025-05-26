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
