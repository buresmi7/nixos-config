{ config, pkgs, ... }:

{
  imports = [
    ./sway.nix
  ];

  home.username = "michal";
  home.homeDirectory = "/home/michal";
  home.stateVersion = "24.05";

  # Enable Home Manager to manage itself
  programs.home-manager.enable = true;
}