{pkgs, ...}:
let 
  mcpPython = pkgs.callPackage ./python.nix {inherit pkgs;};
in 
{
  programs.mcp = {
    enable = true;
    servers = {
      ida-pro-mcp = {
        command = "${mcpPython.py-exec}";
        args = [
          "${mcpPython.py-site-pkgs}/ida_pro_mcp/server.py"
          "--ida-rpc"
          "http://127.0.0.1:13337"
        ];
      };
    };
  };
}