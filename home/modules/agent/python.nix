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
    ps: with ps; [
      # python language server
      # pyright
      ruff

      pipx # Install and Run Python Applications in Isolated Environments
      black # python formatter
      uv # python project package manager

      # my commonly used python packages
      jupyter
      ipython
      pandas
      requests
      pyquery
      pyyaml
      boto3

      # misc
      protobuf # protocol buffer compiler
      numpy
      ida-pro-mcp
    ]
  );
in
{
  inherit mcpPython;
  py-exec = "${mcpPython}/bin/python";
  py-site-pkgs = "${mcpPython}/lib/python3.13/site-packages";
  py-bin = "${mcpPython}/bin";
}
