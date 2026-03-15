{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    plugins = [
      # Manually packaging and enable a plugin
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
          sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
        };
      }
    ];

    shellAliases = {
      ll = "ls -lan";
      cl = "clear";
    };

    functions = {
      pwno-up = ''
        podman run --rm -p 5500:5500 \
        --cap-add=SYS_PTRACE \
        --cap-add=SYS_ADMIN \
        --security-opt seccomp=unconfined \
        --security-opt apparmor=unconfined \
        -v "$PWD/workspace:/workspace" \
        ghcr.io/pwno-io/pwno-mcp:latest
      '';
    };
  };
}
