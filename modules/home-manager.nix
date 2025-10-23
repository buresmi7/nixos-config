{ config, pkgs, lib, ... }:

{
  # Home Manager global settings
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  # Home Manager configuration
  home.username = "michal";
  home.homeDirectory = "/home/michal";
  home.stateVersion = "25.05";

  # Enable Home Manager to manage itself
  programs.home-manager.enable = true;
}