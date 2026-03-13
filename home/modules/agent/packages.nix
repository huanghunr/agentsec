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
        provider = {
          google = {
            models= {
              claude-opus-4-6-thinking = {
                name = "claude-opus-4-6-thinking";
              };
            };
            options = {
              baseURL = "https://llm.xiaochisaas.com/v1";
              apiKey = "{env:XIAOCHI_API_KEY}";
            };
          };
        };
      };
      agents = { 
        security-agent = ./security-agent.md;
      };
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
