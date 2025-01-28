{
	description = "Modular setup with Home Manager";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
		home-manager = {
			url ="github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		hyperland.url = "github:hyprwm/Hyprland";
	};

	outputs = { self, nixpkgs, home-manager, hyperland, ... }:
		let
			system = "x86_64-linux";
		in {
			homeConfigurations."bryce@bryce-nixos" = home-manager.lib.homeManagerConfiguration {
				pkgs = nixpkgs.legacyPackages.${system};

				modules = [
					{
						wayland.windowManager.hyprland = {
							enable = true;
							package = input.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
						};
					}
				];
			};
			nixosConfigurations.bryce-nixos = nixpkgs.lib.nixosSystem {
				system = system;
				modules = [
					./configuration.nix
					home-manager.nixosModules.home-manager
				];
			};
		};
}
