{ buildNpmPackage, fetchFromGitHub }:
buildNpmPackage rec {
  pname = "peerflix";
  version = "0.39.0";

  src = fetchFromGitHub {
    owner = "mafintosh";
    repo = "peerflix";
    rev = "v${version}";
    hash = "sha256-0gytFg1CvTRqJc/9CscyUqmU2yAtblVPLfwmqPzUQEQ=";
  };

  npmDepsHash = "sha256-23A6NUmZsNhW3CPiE1xRC43t1AVYQZ5SgDmcxQ6cHrE=";
  npmPackFlags = [ "--ignore-scripts" ];
  NODE_OPTIONS = "--openssl-legacy-provider";
  postPatch = "ln -s ${./package-lock.json} package-lock.json";
  dontNpmBuild = true;
}
