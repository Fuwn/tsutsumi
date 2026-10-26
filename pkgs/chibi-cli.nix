{
  buildGoModule,
  fetchFromGitHub,
  yae,
}:
buildGoModule rec {
  pname = "chibi";
  version = yae.chibi-cli.version;
  vendorHash = "sha256-gM5qn60DSsd66rjbG5a50QE7gvewg/7hvCiJ34nAPpw=";
  doCheck = false;

  src = fetchFromGitHub {
    owner = "CosmicPredator";
    repo = "${pname}-cli";
    rev = yae.chibi-cli.version;
    hash = yae.chibi-cli.hash;
  };

  ldflags = [
    "-s"
    "-w"
    "-extldflags=-static"
    "-X main.Version=${version}"
    "-X main.Commit=${version}"
  ];
}
