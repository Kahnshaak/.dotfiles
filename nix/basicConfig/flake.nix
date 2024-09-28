# The purpose of this file is having a basic flake that builds home-manager
# for reference of someone who wants to try flakes with home-manager but
# they found the docs as confusing as I did

{
  description = "NixOS + Home Manager flake";

  # Inputs: Declaring external dependencies like nixpkgs and home-manager
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {self, nixpkgs, home-manager }:
  {
    # Define the NixOS system configuration
    nixosConfigurations = {
      bryce-nixos = nixpkgs.lib.nixosSystem {
	system = "x86_64-linux";
	modules = [
	  ./configuration.nix
	  home-manager.nixosModules.home-manager {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.bryce = import ./home.nix;
	  }
	];
      };
    };
  };
}
