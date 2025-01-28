{ config, pkgs, ... }:

{
  home.username = "bryce";
  home.homeDirectory = "/home/bryce";

  home.stateVersion = "24.11";

  # Zsh
  programs.zsh.enable = true;

  # Packages
  home.packages = with pkgs; [
    zsh
  ];

  # Environment variables
  programs.zsh.initExtra = ''
    export EDITOR=nvim
  '';
}
