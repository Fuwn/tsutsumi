{ buildGoModule, fetchFromGitHub }:
buildGoModule rec {
  pname = "html2md";
  version = "20d2bb2";
  vendorHash = "sha256-pquwaU0UleC6Om2T6nICdU1+es9c+nTzF5Gn/9OiUkU=";
  doCheck = false;

  src = fetchFromGitHub {
    owner = "nixports";
    repo = pname;
    rev = "20d2bb24a733bb7eca99539b337dc4cc5832ed8e";
    hash = "sha256-/gZKSNhVq3Um+eLmi0h15dkQyMC7pEi13F/21B3tloQ=";
  };

  ldflags = [
    "-s"
    "-w"
    "-extldflags=-static"
    "-X main.Version=${version}"
    "-X main.Commit=${version}"
  ];
}
