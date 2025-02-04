{ config, pkgs, inputs, ... }:

{
	home.username = "bryce";
	home.stateVersion = "24.11";
	home.homeDirectory = "/home/bryce/";

	home.sessionVariables.NIXOS_OZONE_WL = "1";
#	home.sessionVariables.WALLPAPER = "${config.home.homeDirectory}/Pictures/Wallpapers/5552983.png";
	
	programs.zsh = {
		enable = true;
		enableCompletion = true;
#		autosuggestions.enable = true;
		syntaxHighlighting.enable = true;

		shellAliases = {
			ll = "ls -l";
			la = "ls -la";
			shn = "shutdown now";
		};
		history.size = 10000;
		history.ignoreAllDups = true;

#		ohMyZsh = {
#			enable = true;
#			plugins = [ "git" "zoxide" ];
#			theme = "agnoster";
#		};
	};

	wayland.windowManager.hyprland = {
		enable = true;
		package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
		settings = {
			"$mod" = "SUPER";
			bind = [
				"$mod, F, exec, firefox"
			];
		};
		plugins = [  ];
	};

	programs.wezterm = {
		enable = true;
#		settings = {
#			font_size = 12.0;
#			color_scheme = "Gruvbox Dark";
#		};
	};

	programs.ghostty.enable = true;

	programs.neovim = {
		enable = true;
		plugins = with pkgs.vimPlugins; [
			vim-nix
			vim-fugitive
		];
	};

	programs.tmux = {
		enable = true;
		plugins = with pkgs; [
			tmuxPlugins.sensible
		];
		extraConfig = ''
			set -g mouse on
			bind r source-file ~/.tmux.conf \; display "Config Reloaded"
		'';
	};

	home.packages = with pkgs; [
		zoxide
		vesktop
	#ghostty
	];

#	programs.stylix = {
#		enable = true;
#		theme = "nord";
#		additionalThemes = [ "gruvbox" ];
#	};

	# Dotfiles declaration
	home.file = {
		".wezterm.lua".source = config.lib.file.mkOutOfStoreSymlink "/home/.dotfiles/.wezterm.lua";
		".zshrc".source = config.lib.file.mkOutOfStoreSymlink "/home/.dotfiles/.zshrc";
		".config/hypr/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink "/home/.dotfiles/hyprland.conf";
#	home.file.".zshrc".source = "${config.home.homeDirectory}/.dotfiles/.zshrc";
	};
}
