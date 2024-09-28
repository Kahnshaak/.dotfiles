# User configs
## Setting up user preferences and dotfiles for the system

{ config, pkgs, ... }:

{
  home.username = "bryce";
  home.homeDirectory = "/home/bryce";

  home.stateVersion = "24.11";

# # Neovim
# programs.neovim = {
#   enable = true;
#   package = pkgs.neovim;
#   extraConfig = ''
#     set number
#     set relativenumber
#   '';
# };

  # Packages
  home.packages = with pkgs; [
  ];

  # Environment variables
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

  # Nixvim, the neovim package with nix declarativity
  programs.nixvim = {
    enable = true;
    "~/.config/nvim/option" = ;
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
