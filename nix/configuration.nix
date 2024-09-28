# System-Specific Configuration
## System configs for like networking, services, hardware etc
## Other configs should be in the flake (like packages and package configs)

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];
  
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "bryce-nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Denver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Enable the X11 windowing system.
# services.xserver.enable = true;

  # Enable the Cinnamon Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bryce = {
    isNormalUser = true;
    description = "bryce";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "bryce";

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  #Fonts
  fonts.packages = with pkgs; [
  	nerdfonts
	meslo-lgs-nf
  ];

  # Flatpak
#  services.flatpak.enable = true;
  xdg.portal = {
  	enable = true;
  	wlr.enable = true;
#  	extraPortals = [
#  		pkgs.xdg-desktop-portal-gtk
#  	];
  };

  # System packages
  environment.systemPackages = with pkgs; [
	# DevOps
	## Build Tools
	clang
	gcc
	maven
	ninja

	## Environment
	git
#	(jetbrains.plugins.addPlugins jetbrains.idea-ultimate [ "nixidea" "github-copilot" ]) #codeium-ai 20540
	jetbrains.idea-ultimate
	jetbrains.rider
	jetbrains.jdk
	zed-editor

	# Terminal
	atuin		# Shell history
	bat		# Better cat
	cmatrix
#	cowsay
	curl
	eza		# Better ls
	fastfetch
	figlet		# ASCII word art
	fortune
	fzf
	gnugrep
	lf		# Better ls
#	lolcat
	ripgrep
	thefuck
	tldr
	unzip
	warp-terminal
#	wezterm
	wget

	# Hyprland
	hyprland
	xwayland
	xdg-desktop-portal-gtk
	xdg-desktop-portal-hyprland
	wayland-protocols
	wayland-utils
	wl-clipboard
	wlroots
	networkmanagerapplet
	mako
	libnotify
	swww		# Wall
	waybar		# Bar
	rofi-wayland	# App launcher

	# Other
	vesktop     # discord client
	flameshot	# Screenshots
	lxmenu-data	# Folder data
	shared-mime-info
	nomacs		#Image viewer
	obsidian
#	pavucontrol	# Audio controler
        steam
	syncthing	# Device file sync
	vlc		# Video player
	wireshark
	volctl
	yt-dlp
  ];

  nixpkgs.overlays = [
	(self: super: {
		waybar = super.waybar.overrideAttrs (oldAttrs: {
			mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
	  });
	 }
	)
  ];

  programs.neovim.enable = true;

#  programs.nixvim = {
 # 	enable = true;
#	"~/.config/nvim/option" = <value>;
  #};
 # programs.java.enable = true;

  # Tmux configs
  programs.tmux.enable = true;
  programs.tmux.plugins = [ pkgs.tmuxPlugins.sensible ];

  # List services that you want to enable:
	virtualisation.docker.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "unstable"; # Did you read the comment?
}
