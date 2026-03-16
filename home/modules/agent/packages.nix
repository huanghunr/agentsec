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
    agent-skills = {
      enable = true;

      sources.ctf = {
        path = inputs.ctf-skills;
        subdir = ".";
      };

      skills.enable = [
        "solve-challenge"
        "ctf-web"
        "ctf-pwn"
        "ctf-crypto"
        "ctf-reverse"
        "ctf-forensics"
        "ctf-osint"
        "ctf-malware"
        "ctf-misc"
      ];

      targets.opencode = {
        enable = true;
        dest = "$HOME/.config/opencode/skill";
        structure = "symlink-tree";
      };
    };

    opencode = {
      enable = true;
      enableMcpIntegration = true;
      package = unstable.opencode;
      settings = {
        theme = "system";
        provider = {
          google = {
            models = {
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
        nixos-agent = ./this-project-dev-agent.md;
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
