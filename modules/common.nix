{ config, pkgs, inputs, ... }:

{
  # Enable flakes and new command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Boot configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Network configuration
  networking.networkmanager.enable = true;

  # Internationalization
  time.timeZone = "Europe/Prague";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "cs_CZ.UTF-8";
    LC_IDENTIFICATION = "cs_CZ.UTF-8";
    LC_MEASUREMENT = "cs_CZ.UTF-8";
    LC_MONETARY = "cs_CZ.UTF-8";
    LC_NAME = "cs_CZ.UTF-8";
    LC_NUMERIC = "cs_CZ.UTF-8";
    LC_PAPER = "cs_CZ.UTF-8";
    LC_TELEPHONE = "cs_CZ.UTF-8";
    LC_TIME = "cs_CZ.UTF-8";
  };

  # Console keymap
  console.keyMap = "us";

  # Enable X11 windowing system
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Enable sound with pipewire
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define main user account
  users.users.michal = {
    isNormalUser = true;
    description = "Michal";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Enable sudo for wheel group
  security.sudo.wheelNeedsPassword = false;

  # System packages - minimal setup
  environment.systemPackages = with pkgs; [
    git
    mc  # Midnight Commander
  ];

  # Enable SSH
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;  # Allow password auth for initial setup
    };
  };

  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
  };

  # This value determines the NixOS release
  system.stateVersion = "24.05";
}