{
  config,
  lib,
  pkgs,
  ...
}:

{
  nixpkgs.config.allowUnfree = true;
  imports = [
    ./nixos
  ];
  environment.systemPackages = with pkgs; [
    wget
    vim
  ];

  users.users.nixos = {
    isNormalUser = true;
  };
  programs.nix-ld={
    enable = true;
    libraries = [
    ];
  };

  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
    shellAliases = {
      # pwno-up = ''
      #   podman run --rm -p 5500:5500 \
      #     --cap-add=SYS_PTRACE \
      #     --cap-add=SYS_ADMIN \
      #     --security-opt seccomp=unconfined \
      #     --security-opt apparmor=unconfined \
      #     -v "$PWD/workspace:/workspace" \
      #     ghcr.io/pwno-io/pwno-mcp:latest
      # '';
    };
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "25.11";
}
