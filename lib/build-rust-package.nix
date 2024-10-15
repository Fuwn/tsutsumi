{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
{
  pname,
  version,
  githubOwner,
  githubHash,
  cargoHash ? null,
  description ? null,
  license,
  maintainers ? null,
  buildInputs ? [ ],
  nativeBuildInputs ? [ ],
  cargoLock ? null,
  postPatch ? null,
  cargoPatches ? [ ],
}:
rustPlatform.buildRustPackage rec {
  inherit
    pname
    version
    buildInputs
    nativeBuildInputs
    cargoHash
    cargoLock
    postPatch
    cargoPatches
    ;

  src = fetchFromGitHub {
    owner = githubOwner;
    repo = pname;
    rev = version;
    hash = githubHash;
  };

  doCheck = false;

  meta = with lib; {
    inherit description license maintainers;

    homepage = "https://github.com/${githubOwner}/${pname}";
    mainProgram = pname;
  };
}
