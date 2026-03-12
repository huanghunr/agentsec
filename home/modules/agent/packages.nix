{ pkgs, inputs, ... }:
let
  unstable = import inputs.unstablepkgs {
    system = pkgs.system;
    config.allowUnfree = true;
  };
  codex = pkgs.callPackage ./codex.nix {};

in
{
  home.packages = [
    unstable.opencode
    unstable.claude-code
    codex
  ];
}