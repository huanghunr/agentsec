{pkgs, inputs, ...}:
let
  pwno-up = pkgs.callPackage ./pwno-up/default.nix {};
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
  ]
  ++[
    jadx
  ]
  ++[
    google-chrome
  ];
}