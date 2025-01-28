{ config, pkgs, ... }:

{
	imports = [ 
		./hardware-configuration.nix
		<home-manager/nixos>
	];

	nix = {
		package = pkgs.nixVersions.unstable;
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
		description = "The Dude";
		extraGroups = [ "wheel" "docker" "video" "networkmanager"];
		shell = pkgs.zsh;
	};
	home-manager.users.bryce = { pkgs, ... }: {
		home.packages = [ pkgs.atool pkgs.httpie ];
		programs.zsh.enable = true;
	};

	nixpkgs.config.allowUnfree = true;

	environment.systemPackages = with pkgs; [
		vim
		kitty
		vesktop

		# Wayland
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

	#	programs.home-manager.enable = true;
	programs.hyprland.enable = true;
	programs.zsh.enable = true;
	programs.steam.enable = true;


	system.stateVersion = "unstable";
}
