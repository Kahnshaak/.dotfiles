# Development/flake.nix
{
  description = "Combined Dev Flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    python-flake.url = "path:./python"; # Make sure it is direct path and not relative
#   java-flake.url = "path:../java";
#   dotnet-flake.url = "path:../dotnet";
#   c-flake.url = "path:../c";
#   cpp-flake.url = "path:../cpp";
#   system = "x86_64-linux";
  };

  # Make sure to add any definitions for flake paths that need to be included
  outputs = { self, nixpkgs, python-flake, ... }:
  let 
    pkgs = import nixpkgs { system = "x86_64-linux"; };
  in
  {
    devShells.python = python-flake.devShells.default;
    # Include other rules for other build systems following this pattern
    # You can call this from the command line with:
    # nix develop .#python
  };
}
