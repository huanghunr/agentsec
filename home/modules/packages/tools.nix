{ pkgs, inputs, ... }:
let
  pwno-up = pkgs.callPackage ./pwno-up.nix { };
  idalib-up = pkgs.callPackage ./idalib-up.nix { };
  blutter = pkgs.callPackage ./blutter.nix { };
in
{
  home.packages =
    with pkgs;
    [
      binwalk
      upx
      socat
    ]
    ++ [
      inputs.pwndbg.packages.${pkgs.system}.default
    ]
    ++ [
      pwno-up
      idalib-up
    ]
    ++ [
      android-tools
      jadx
      blutter
    ]
    ++ [
      google-chrome
    ];
}
