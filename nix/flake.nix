{
	description = "Modular setup with Home Manager";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
		home-manager = {
			url ="github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		hyprland.url = "github:hyprwm/Hyprland";
	};

	outputs = { self, nixpkgs, home-manager, hyprland, ... }@inputs:
		let
			system = "x86_64-linux";
			pkgs = import nixpkgs { inherit system; };
		in {

			nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
				inherit system;
				modules = [
					./configuration.nix
					home-manager.nixosModules.home-manager
				];
				specialArgs = { inherit inputs; };
			};
			
			homeConfigurations.bryce = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				extraSpecialArgs = { inherit inputs; };
				modules = [ 
					./home.nix
				 ];
			};
		};
}
