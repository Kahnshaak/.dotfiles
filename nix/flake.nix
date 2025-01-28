{
	description = "Modular setup with Home Manager";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		home-manager.url = "github:nix-community/home-manager";
	};

	outputs = { self, nixpkgs, home-manager, ... }:
		let
			system = "x86_64-linux";
			pkgs = import nixpkgs { system = system; };
		in {
			nixosConfigurations.laptop = pkgs.lib.nixosSystem {
				system = ${ system };
				modules = [
					./configuration.nix
					home-manager.nixosModules.home-manager
				];
			};
		};
}
