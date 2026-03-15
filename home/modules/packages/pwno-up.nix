{ pkgs, ... }:
let
  exec = ''
    #!/usr/bin/env bash
    set -euo pipefail

    podman run --rm -p 5500:5500 \
      --cap-add=SYS_PTRACE \
      --cap-add=SYS_ADMIN \
      --security-opt seccomp=unconfined \
      --security-opt apparmor=unconfined \
      -v "$PWD/workspace:/workspace" \
      ghcr.io/pwno-io/pwno-mcp:latest
  '';
in
pkgs.stdenv.mkDerivation {
  pname = "pwno-up";
  version = "1.0.0";

  src = ./.;

  nativeBuildInputs = [ ];

  buildInputs = [ ];

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    echo "${exec}" > $out/bin/pwno-up
    chmod +x $out/bin/pwno-up
  '';
}
