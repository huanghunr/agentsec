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
  };

  home.stateVersion = "25.11";
}
