{ config, pkgs, lib, nur, ... }:

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

  # User packages
  home.packages = with pkgs; [
    bitwarden
  ];

  # Git configuration
  programs.git = {
    enable = true;
    userName = "Michal";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = false;
      };
    };
  };

  # Firefox configuration with extensions
  programs.firefox = {
    enable = true;
    profiles.michal = {
      id = 0;
      name = "michal";
      isDefault = true;
      
      # Firefox extensions from NUR
      extensions = with nur.repos.rycee.firefox-addons; [
        bitwarden
      ];
      
      # Firefox settings
      settings = {
        "browser.startup.homepage" = "about:home";
        "browser.search.defaultenginename" = "Google";
        "browser.search.order.1" = "Google";
        # Privacy settings
        "privacy.donottrackheader.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
      };
    };
  };
}