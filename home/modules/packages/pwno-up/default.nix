{ pkgs, ...}:

pkgs.stdenv.mkDerivation {
  pname = "pwno-up";
  version = "1.0.0";

  src = ./.;

  nativeBuildInputs = [];

  buildInputs = [];

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp run.sh $out/bin/pwno-run
    chmod +x $out/bin/pwno-run
  '';
}