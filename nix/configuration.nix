{ config, pkgs, ... }:

{
	imports = [ ./hardware-configuration.nix ];

	users.users.bryce = {
		isNormalUser = true;
		home = "/home/bryce";
		description = "Bryce";
		extraGroups = [ "wheel" "docker" "video"];
		shell = pkgs.zsh;
	};

	environment.systemPackages = with pkgs; [
		steam
		vesktop

		# Podman tools to replace docker
		dive
		podman-tui
		podman-compose
	];

	#	wayland = {		enable = true;		displayManager = {			gdm.enable = false;		};		windowManager.enable = true;		windowManager.hyperland.enable = true;	};

	hardware.opengl = {
		enable = true;
		driSupport = true;
		extraPackages = with pkgs; [
			vulkan-loader
			vulkan-tools
		];
	};

	#	services.docker = {		enable = true;		group = "docker";	};
	virtualisation = {
		containers.enable = true;
		podman = {
			enable = true;
			dockerCompat = true; # Makes a docker group
			defaultNetwork.settings.dns_enabled = true;
		};
	};

	services.syncthing = {
		enable = true;
		user = "bryce";
	};

	environment.variables = {
		XDG_SESSION_DESKTOP = "hyperland";
		WLR_NO_HARDWARE_CURSORS = "1";
	};
}
