{pkgs, inputs, ...}:
let
  pwno-up = pkgs.callPackage ./pwno-up.nix {};
  idalib-up = pkgs.callPackage ./idalib-up.nix {};
in 
{
  home.packages = with pkgs; 
  [
    binwalk
    upx
    socat
  ]
  ++[
    inputs.pwndbg.packages.${pkgs.system}.default
  ]
  ++[
    pwntools
    ropgadget
    pwno-up
    idalib-up
  ]
  ++[
    jadx
  ]
  ++[
    google-chrome
  ];
}