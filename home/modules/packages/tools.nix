{pkgs, inputs, ...}:{
  home.packages = with pkgs; 
  [
    binwalk
    upx
    cyberchef
    socat
  ]
  ++[
    inputs.pwndbg.packages.${pkgs.system}.default
  ]
  ++[
    pwntools
    ropgadget
  ]
  ++[
    jadx
  ];
}