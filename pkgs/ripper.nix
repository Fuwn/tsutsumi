{
  source,
  fetchzip,
  writeShellScriptBin,
  python3,
  runtimeShell,
}:
let
  ripper = fetchzip {
    inherit (source) url sha256;
  };

  python = python3.withPackages (
    ps: with ps; [
      requests
    ]
  );
in
writeShellScriptBin "ripper" ''
  #!${runtimeShell}

  ${python}/bin/python3 ${ripper}/ripper.py "$@"
''
