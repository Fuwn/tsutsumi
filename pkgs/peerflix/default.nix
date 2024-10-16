{
  buildNpmPackage,
  fetchzip,
  source,
}:
buildNpmPackage {
  inherit (source) version;

  pname = "peerflix";

  src = fetchzip {
    inherit (source) url sha256;
  };

  npmDepsHash = "sha256-23A6NUmZsNhW3CPiE1xRC43t1AVYQZ5SgDmcxQ6cHrE=";
  npmPackFlags = [ "--ignore-scripts" ];
  NODE_OPTIONS = "--openssl-legacy-provider";
  postPatch = "ln -s ${./package-lock.json} package-lock.json";
  dontNpmBuild = true;
}
