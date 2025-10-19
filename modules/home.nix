{ config, pkgs, ... }:

{
  home.username = "michal";
  home.homeDirectory = "/home/michal";
  home.stateVersion = "24.05";

  # Enable Home Manager to manage itself
  programs.home-manager.enable = true;

  # Sway configuration
  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";  # Use Super key as modifier
      terminal = "foot";
      menu = "wofi --show drun";
      
      # Basic keybindings (defaults mostly)
      keybindings = let
        modifier = "Mod4";
      in {
        "${modifier}+Return" = "exec foot";
        "${modifier}+Shift+q" = "kill";
        "${modifier}+d" = "exec wofi --show drun";
        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+e" = "exec swaynag -t warning -m 'Exit Sway?' -b 'Yes' 'swaymsg exit'";
      };
    };
  };
}