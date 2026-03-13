{ pkgs, inputs, ... }:
let
  unstable = import inputs.unstablepkgs {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in
{
  home.packages = [
  ];

  programs = {
    opencode = {
      enable = true;
      enableMcpIntegration = true;
      package = unstable.opencode;
      settings = {
        theme = "system";
      };
      agents = { };
    };

    codex = {
      enable = true;
      package = unstable.codex;
    };

    claude-code = {
      enable = true;
      package = unstable.claude-code;
    };
  };

}
