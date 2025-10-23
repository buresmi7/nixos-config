{ config, pkgs, ... }:

{
  # Enable COSMIC Desktop Environment
  services.desktopManager.cosmic.enable = true;
  
  # Enable display manager
  services.displayManager.cosmic-greeter.enable = true;
  
  # Enable XWayland for legacy X11 apps
  services.xserver.enable = true;

}