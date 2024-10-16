# User configs
## Setting up user preferences and dotfiles for the system

{ config, pkgs, ... }:

{
  home.username = "bryce";
  home.homeDirectory = "/home/bryce";

  home.stateVersion = "24.11";

  home.sessionVariables.WALLPAPER = "~/Pictures/Wallpapers/5552983.png";

  # Packages
  home.packages = with pkgs; [
    # WM utils
    rofi
    feh
    
  ];

  # Environment variables
  fonts.packages = with pkgs; {
    nerdfonts
    meslo-lgs-nf
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    ohMyZsh.enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enabe = true;

    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
      shn = "shutdown now";
    };

    history.size = 10000;
    history.ignoreAllDups = true;

    initExtra = ''
    export EDITOR=nvim
  '';
  };

  # Tmux
  programs.tmux = {
    enable == true;
    plugins = with pkgs; {
      tmuxPlugins.sensible
    };
  };

  # Dotfiles declaration
  home.file.".wezterm.lua".source = ~/.dotfiles/.wezterm.lua;
  home.file.".zshrc".source = ~/.dotfiles/.zshrc;
  home.file.".config/hypr/hyprland.conf".source = ~/.dotfiles/hyprland.conf;
}
