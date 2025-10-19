{ config, pkgs, ... }:

{
  # Enable Wayland and Sway
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # Enable XWayland for legacy X11 apps
  services.xserver.enable = true;
  
  # Display manager for Sway
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "greeter";
      };
    };
  };

  # System packages for desktop environment
  environment.systemPackages = with pkgs; [
    git
    mc  # Midnight Commander
    
    # Sway essentials
    foot  # Wayland-native terminal
    waybar  # Status bar for Sway
    wofi  # Application launcher
    wl-clipboard  # Clipboard utilities
    grim  # Screenshot tool
    slurp  # Screen selection tool
    greetd.tuigreet  # Display manager
  ];
}