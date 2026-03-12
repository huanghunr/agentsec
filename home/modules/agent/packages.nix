{pkgs, inputs, ...}:{
  home.packages = [
    inputs.unstablepkgs.opencode
  ];
}