# Reproducible Configuration
## Used for modularization. Most packages and other configurations are centralized here
## outside what should be placed in home.nix (like user configurations)

{
  # Inputs: Declaring external dependencies like nixpkgs and home-manager
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:pta2002/nixvim";
    nsearch = {
      url = "github:niksingh710/nsearch";
      inputs.nixpkgs.follows = "nixpkgs";
    }; # CLI package search
  };

  outputs = {self, nixpkgs, home-manager, nixvim, nsearch, ... }:
    let
      systemPackages = pkgs: with pkgs; [
	clang
	gcc
	geany
	git
	ninja

	# Terminal
	atuin
	bat
	cmatrix
	curl
	eza
	fastfetch
	figlet
	fortune
	fzf
	gnugrep
	lf
	ripgrep
	thefuck
	tldr
	unzip
	wget

	# Other
	brave
	flameshot
	lxmenu-data	  # Folder data
	shared-mime-info
	nomacs		  # Image viewer
	obsidian
#	pavucontrol
	qalculate-gtk
	steam
	syncthing
	vesktop
	vlc
	volctl
	yt-dlp
      ];
  {
    # Define the NixOS system configuration
    nixosConfigurations.bryce-nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
	./configuration.nix
	home-manager.nixosModules.home-manager {
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.users.bryce = {
	    import ./home.nix;

	    programs.freetube.enable = true;
	    programs.qutebrowser = {
	      enable = true;
	    };

	    # Hyprland
	    programs.hyprland = {
	      enable = true;
	      xwayland.enable = true;
	      xwayland.hidpi = true;
	    };

	    # Wezterm
	    programs.wezterm = {
	      enable = true;
	      colorSchemes = "Atlas (base16)";
	      enableZshIntegration = true;
	      extraConfig = {
		font = "JetBrains Mono";
		window_background_image = "$HOME/Pictures/Wallpapers/leapOfFaith.jpg";
		window_background_opacity = 0.2;
	      };
	    };

	    programs.zoxide = {
	      enable = true;
	      enableZshIntegration = true;
	    };
	  };
	}
      ];
    };
  };
}
