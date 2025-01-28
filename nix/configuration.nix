{ config, pkgs, ... }:

{
	imports = [ 
		./hardware-configuration.nix
	];

	nix = {
		package = pkgs.nixVersions.stable;
		extraOptions = ''
			experimental-features = nix-command flakes
		'';
	};

	networking = {
		networkmanager.enable = true;
		hostName = "bryce-nixos";
		firewall.enable = false;
	};

	users.users.bryce = {
		isNormalUser = true;
		home = "/home/bryce";
		description = "Bryce";
		extraGroups = [ "wheel" "docker" "video" "networkmanager"];
		shell = pkgs.zsh;
	};

	nixpkgs.config.allowUnfree = true;

	environment.systemPackages = with pkgs; [
		vim
		kitty
		vesktop

		# Wayland
		hyprland
		waybar
		xdg-desktop-portal-hyprland
		xdg-desktop-portal
		wl-clipboard
		grim
		slurp

		# Podman tools to replace docker
		dive
		podman-tui
		podman-compose
	];

	#	wayland = {		enable = true;		displayManager = {			gdm.enable = false;		};		windowManager.enable = true;		windowManager.hyperland.enable = true;	};

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	hardware.graphics = {
		enable = true;
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

	services.displayManager = {
		sddm = {
			enable = true;
			wayland.enable = true;
		};

		defaultSession = "hyprland";
	};

	programs.hyprland.enable = true;
	programs.zsh.enable = true;
	programs.steam.enable = true;

	#	environment.variables = {		XDG_SESSION_DESKTOP = "hyperland";		WLR_NO_HARDWARE_CURSORS = "1";	};

	system.stateVersion = "unstable";
}
