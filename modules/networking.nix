{ config, pkgs, ... }:

{
  # Network configuration
  networking.networkmanager.enable = true;

  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ ];
  };

  # Disable SSH
  services.openssh = {
    enable = false;
  };
}