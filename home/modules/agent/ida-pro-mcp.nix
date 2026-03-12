# toolz.nix
{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  wheel,
  fetchFromGitHub
}:

buildPythonPackage rec {
  pname = "ida-pro-mcp";
  version = "1.4.0";

  src = fetchFromGitHub {
    owner = "mrexodia";
    repo = "mrexodia/ida-pro-mcp";
    hash = "sha256-IxBBlgrGd2hwtB7aFzU+tD7vts4sAtXEQ1xXpdj4RNo=";
  };

  # do not run tests
  doCheck = false;

  # specific to buildPythonPackage, see its reference
  pyproject = true;
  build-system = [
    setuptools
    wheel
  ];
}