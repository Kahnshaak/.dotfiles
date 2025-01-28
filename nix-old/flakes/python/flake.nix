{
  description = "This has python build environment";

  inputs = {
	nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
	system = "x86_64-linux";
  }
  
  outputs = { self, nixpkgs, ... }:
  let
	pkgs = import nixpkgs { system };
	systemPackages = pkgs: with pkgs; [
	  python3Full
	]
  in
  {
	# TODO add outputs
	system
  }
}
