{ config, pkgs, lib, ... }:

{
  # Home Manager configuration for user
  home.username = "michal";
  home.homeDirectory = "/home/michal";
  
  # State version - determines config format and default behavior
  # WARNING: Do not change this after initial installation unless you know what you're doing
  # This is separate from the NixOS version in flake.nix
  home.stateVersion = "25.05";

  # Enable Home Manager to manage itself
  programs.home-manager.enable = true;
}