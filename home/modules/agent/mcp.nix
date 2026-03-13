{pkgs, ...}:
let 
  mcpPython = pkgs.callPackage ./python.nix {inherit pkgs;};
  mcpSettings = {
      ida-pro-mcp = {
        command = "${mcpPython.py-exec}";
        args = [
          "${mcpPython.py-site-pkgs}/ida_pro_mcp/server.py"
          "--ida-rpc"
          "http://127.0.0.1:13337"
        ];
      };
      mcp-nixos = {
        command = "nix";
        args = [
          "run"
          "github:utensils/mcp-nixos"
          "--"
        ];
      };
  };
in 
{
  home.packages = [
    mcpPython.mcpPython
  ];
  home.file.".local/mcp/mcpPython".source = "${mcpPython.mcpPython}";

  programs.mcp = {
    enable = true;
    servers = mcpSettings;
  };
}