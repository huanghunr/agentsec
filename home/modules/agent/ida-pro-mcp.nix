{
  lib,
  buildPythonPackage,
  setuptools,
  wheel,
  fetchFromGitHub,
  idapro,
  tomli_w,
  ...
}:

buildPythonPackage rec {
  pname = "ida-pro-mcp";
  version = "1.4.0";

  src = fetchFromGitHub {
    owner = "mrexodia";
    repo = "ida-pro-mcp";
    rev = "27722e929052757f4baf074776904effdb23c012";
    hash = "sha256-abH6i/Xr3P3/gP8L151FZBU9ovp/olFWwKenPz7BuF8=";
  };

  # do not run tests
  doCheck = false;

  # specific to buildPythonPackage, see its reference
  pyproject = true;
  build-system = [
    setuptools
    wheel
  ];

    dependencies = [
      idapro
      tomli-w
  ];
}