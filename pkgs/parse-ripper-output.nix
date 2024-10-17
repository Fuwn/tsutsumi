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
      markdown
    ]
  );
in
writeShellScriptBin "parse-ripper-output" ''
  #!${runtimeShell}

  ${python}/bin/python3 ${ripper}/extras/parse-rip-output.py "$@"
''
