{
  lib,
  fetchFromGitHub,
  writeShellApplication,
  python3,
  git,
  cmake,
  ninja,
  pkg-config,
  gcc,
  icu,
  capstone,
}:
let
  version = "unstable-2026-03-17";
  src = fetchFromGitHub {
    owner = "worawit";
    repo = "blutter";
    rev = "129377f65dffecd59535eb35041de534c4dea2ea";
    hash = "sha256-88ErOUjzXrUtxpK7wmoo2nhyByf5mU+f3BbScI3BsCA=";
  };

  pythonEnv = python3.withPackages (
    ps: with ps; [
      pyelftools
      requests
    ]
  );
  pkgConfigPath = lib.makeSearchPathOutput "dev" "lib/pkgconfig" [
    icu
    capstone
  ];
  cmakePrefixPath = lib.makeSearchPathOutput "dev" "" [
    icu
    capstone
  ];
in
writeShellApplication {
  name = "blutter";
  runtimeInputs = [
    pythonEnv
    git
    cmake
    ninja
    pkg-config
    gcc
  ];
  text = ''
    set -euo pipefail

    stateRoot="''${XDG_STATE_HOME:-$HOME/.local/state}/blutter"
    workDir="$stateRoot/${version}"

    if [ ! -d "$workDir" ]; then
      mkdir -p "$stateRoot"
      cp -r "${src}" "$workDir"
      chmod -R u+w "$workDir"
    fi

    export PKG_CONFIG_PATH="${pkgConfigPath}''${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"
    export CMAKE_PREFIX_PATH="${cmakePrefixPath}''${CMAKE_PREFIX_PATH:+:$CMAKE_PREFIX_PATH}"

    exec "${pythonEnv}/bin/python" "$workDir/blutter.py" "$@"
  '';

  meta = {
    description = "Flutter reverse engineering helper by compiling Dart runtime";
    homepage = "https://github.com/worawit/blutter";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
    mainProgram = "blutter";
  };
}
