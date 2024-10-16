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

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "bryce-nixos"; # Define your hostname.
  networking.firewall.enable = false;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "America/Denver";

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

  # DE Configs
  services.xserver = {
    enable = false;
    xkb.layout = "us";
    xkb.variant = "";
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  xdg.portal = {
  	enable = true;
  	wlr.enable = true;
#  	extraPortals = [
#  		pkgs.xdg-desktop-portal-gtk
#  	];
  };

  # Display Manager
# services.xserver.displayManager.lightdm.enable = false;
# services.xserver.displayManager.sddm.enable = false;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
	command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd hyprland";
	user = "bryce";
      };
    };
  };

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "bryce";

  # Enable CUPS to print documents.
  services.printing.enable = false;

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

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  #Fonts
  fonts.packages = with pkgs; [
  	nerdfonts
	meslo-lgs-nf
  ];

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    kitty
	#Hyprland
	mesa
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
  ];

  nixpkgs.overlays = [
	(self: super: {
		waybar = super.waybar.overrideAttrs (oldAttrs: {
			mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
	  });
	 }
	)
  ];

  # List services that you want to enable:
  virtualisation.docker.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.twingate = {
    enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "unstable"; # Did you read the comment?
}
