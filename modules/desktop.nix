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
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "greeter";
      };
    };
  };

  # Fonts for better visual appearance
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    font-awesome
    dejavu_fonts
    liberation_ttf
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  # GTK themes and icons
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
    tuigreet  # Display manager
    
    # Wallpaper and backgrounds
    swaybg  # Wallpaper tool for Sway
    
    # System utilities
    brightnessctl  # Brightness control
    
    # GTK themes and appearance
    adwaita-icon-theme
    gnome-themes-extra
    papirus-icon-theme
    
    # GUI applications
    firefox
    networkmanagerapplet
    pavucontrol  # PulseAudio volume control
  ];

  # Enable dconf for GTK settings
  programs.dconf.enable = true;
  
  # GTK theme settings
  environment.sessionVariables = {
    GTK_THEME = "Adwaita:dark";
    QT_QPA_PLATFORMTHEME = "gtk2";
  };
}