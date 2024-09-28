# Reproducible Configuration
## Used for modularization. Most packages and other configurations are centralized here
## outside what should be placed in home.nix (like user configurations)

{
  # Inputs: Declaring external dependencies like nixpkgs and home-manager
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nsearch = {
      url = "github:niksingh710/nsearch";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, nixpkgs, home-manager }:
    let
      systemPackages = pkgs: with pkgs; [
	firefox
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
	    
	    # Hyprland
	    programs.hyprland = {
	      enable = true;
	      xwayland.enable = true;
	      xwayland.hidpi = true;
	    };

	    programs.sway.enable = true;
	    
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

	    home.packages = with pkgs; [
	      rofi
	      feh
	      wezterm
	    ];

	    home.sessionVariables.WALLPAPER = "~/Pictures/Wallpapers/5552983.png";
	  };
	}
      ];
    };
  };
}