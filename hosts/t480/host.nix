{ config, lib, pkgs, ... }:

{
  # Hostname
  networking.hostName = "t480-nixos";

  # Hardware platform
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  
  # Intel CPU microcode updates
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  
  # Intel graphics (OpenGL)
  hardware.graphics = {
    enable = true;
  };

  # Enable touchpad support
  services.xserver.libinput.enable = true;

  # Power management for laptop
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };
  };

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # WiFi and networking
  networking.wireless.enable = false; # We use NetworkManager instead
  
  # T480 specific packages
  environment.systemPackages = with pkgs; [
    # Power management
    powertop
    acpi
    
    # Network tools
    networkmanagerapplet
    
    # Bluetooth
    bluez
    bluez-tools
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable firmware updates
  services.fwupd.enable = true;
}