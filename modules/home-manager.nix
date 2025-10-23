{ config, pkgs, lib, ... }:

{
  # Home Manager global settings
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  # Home Manager configuration
  home.username = "michal";
  home.homeDirectory = "/home/michal";
  
  # State version - determines config format and default behavior
  # WARNING: Do not change this after initial installation unless you know what you're doing
  # This is separate from the NixOS version in flake.nix
  home.stateVersion = "25.11";

  # Enable Home Manager to manage itself
  programs.home-manager.enable = true;
}