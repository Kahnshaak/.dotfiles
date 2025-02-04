{ config, pkgs, ... }:

{
	imports = [ 
		./hardware-configuration.nix
	#	<home-manager/nixos>
	];

	nix = {
		package = pkgs.nixVersions.git;
		extraOptions = ''
			experimental-features = nix-command flakes
		'';
	};

	networking = {
		networkmanager.enable = true;
		hostName = "bryce-nixos";
		firewall.enable = false;
	};

	programs.home-manager.enable = true;
	users.users.bryce = {		
		isNormalUser = true;		
		home = "/home/bryce";		
		description = "The Dude";		
		extraGroups = [ "wheel" "docker" "video" "networkmanager"];		
		shell = pkgs.zsh;	
	};

	nixpkgs.config.allowUnfree = true;

	environment.systemPackages = with pkgs; [
		vim
		kitty
		tmux
		git

		# Wayland
		waybar
		xdg-desktop-portal-hyprland
		xdg-desktop-portal
		wl-clipboard
		grim
		slurp
		tofi

		# Podman tools to replace docker
		dive
		podman-tui
		podman-compose
	];


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

	programs.hyprland.enable = true;
	programs.zsh.enable = true;
	programs.steam.enable = true;


	system.stateVersion = "unstable";
}
