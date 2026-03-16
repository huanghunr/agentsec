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

      idalib-mcp = {
        enable = true;
        type = "remote";
        url = "http://127.0.0.1:8745/mcp";
      };
      
      mcp-nixos = {
        command = "nix";
        args = [
          "run"
          "github:utensils/mcp-nixos"
          "--"
        ];
      };

      pwno-mcp = {
        enable = true;
        type = "remote";
        url = "http://127.0.0.1:5500/mcp";
      };

      chrome-devtools = {
        command = "npx";
        args = [
          "-y"
          "chrome-devtools-mcp@latest"
          "--executablePath=${pkgs.google-chrome}/bin/google-chrome-stable"
          "--headless"
          "--chromeArg='--no-sandbox'"
          "--chromeArg='--disable-dev-shm-usage'"
          "--logFile /tmp/chrome-devtools-mcp.log"
        ];
      };
      mcp_windbg_http = {
        type = "remote"; # start in windows by "mcp-windbg --transport streamable-http --host 127.0.0.1 --port 8000"
        url = "http://127.0.0.1:8000/mcp";
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