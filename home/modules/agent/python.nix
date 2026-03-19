{ pkgs, ... }:
let
  python = pkgs.python313.override {
    self = python;
    packageOverrides = pyfinal: pyprev: {
      ida-pro-mcp = pyfinal.callPackage ./ida-pro-mcp.nix {
        idapro = pyfinal.callPackage ./pythonPkgs/pythonPkg-ida-pro.nix { };
        tomli_w = pkgs.python313Packages.tomli-w;
      };
    };
  };
in
let
  mcpPython = python.withPackages (
    ps:
    with ps;
    [
      # Tooling
      ruff
      black
      mypy
      pytest
      uv
      pipx
    ]
    ++ [
      # Data / notebook
      jupyter
      jupyterlab
      ipykernel
      ipython
      numpy
      pandas
      scipy
      matplotlib
      tqdm
      z3-solver
    ]
    ++ [
      # Networking / scraping
      requests
      httpx
      pyquery
      beautifulsoup4
      lxml
      pyyaml
      python-dotenv
      boto3
    ]
    ++ [
      # Security / crypto helpers
      scapy
      pwntools
      cryptography
      pynacl
      ida-pro-mcp
    ]
    ++ [
      # Misc
      protobuf
      pydantic
      orjson
    ]
  );
in
{
  inherit mcpPython;
  py-exec = "${mcpPython}/bin/python";
  py-site-pkgs = "${mcpPython}/lib/python3.13/site-packages";
  py-bin = "${mcpPython}/bin";
}
