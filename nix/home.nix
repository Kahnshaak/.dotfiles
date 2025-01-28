{ config, pkgs, ... }:

{
	#	home.username = "bryce";
	home.stateVersion = "24.11";

	home.sessionVariables.WALLPAPER = "~Pictures/Wallpapers/5552983.png";
	
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestions.enable = true;
		syntaxHighlighting.enable = true;

		shellAliases = {
			ll = "ls -l";
			la = "ls -la";
			shn = "shutdown now";
		};
		history.size = 10000;
		history.ignoreAllDups = true;

		ohMyZsh = {
			enable = true;
			plugins = [ "git" "zoxide" ];
			theme = "agnoster";
		};
	};

	wayland.windowManager.hyprland = {
		enable = true;
		home.sessionVariables.NIXOS_OZONE_WL = "1";
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
		settings = {
			font_size = 12.0;
			color_scheme = "Gruvbox Dark";
		};
	};

	programs.ghostty.enable = true;

	programs.neovim = {
		enable = true;
		package = with pkgs.vimPlugins; [
			vim-nix
			vim-fugitive
		];
	};

	programs.tmux = {
		enable = true;
		plugins = with pkgs; {
			tmuxPlugins.sensible
		};
		extraConfig = ''
			set -g mouse on
			bind r source-file ~/.tmux.conf \; display "Config Reloaded"
		'';
	};

	home.packages = with pkgs; [
		zoxide
		tmux
	#ghostty
	];

	programs.stylix = {
		enable = true;
		theme = "nord";
		additionalThemes = [ "gruvbox" ];
	};

	# Dotfiles declaration
	home.file.".wezterm.lua".source = ~/.dotfiles/.wezterm.lua;
	home.file.".zshrc".source = ~/.dotfiles/.zshrc;
	home.file.".config/hypr/hyprland.conf".source = ~/.dotfiles/hyprland.conf;

}
