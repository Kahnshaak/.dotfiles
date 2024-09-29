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

  programs.nixvim = {
    enable = true;
#   "~/.config/nvim/option" = ;
    plugins = {
      start = {
        telescope = {
          plugin = { repo = "nvim-telescope/telescope.nvim"; };
        };
        treesitter = {
          plugin = { repo = "nvim -treesitter/nvim-treesitter"; };
        };
      };
    };

    # Settings for init.vim or init.lua
    settings = {
      vim.o.number = true;
      vim.o.relativenumber = true;
      vim.o.tabstop = 2;
      vim.o.shiftwidth = 4;
      vim.o.expandtab = true;
    };
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
