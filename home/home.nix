{ pkgs, ... }:
{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  imports = [
    ./modules/packages
  ];

  programs = {
    git = {
      enable = true;
      settings = {
        user.name = "huanghunr";
        user.email = "huanghunr@outlook.com";
        gpg = {
          format = "ssh";
        };
      };
    };
    starship = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        add_newline = false;
        aws.disabled = true;
        gcloud.disabled = true;
        line_break.disabled = true;
      };
    };

    bash = {
      enable = true;
      shellAliases = {
        ll = "ls -lah";
      };
    };
  };

  home.stateVersion = "25.11";
}
