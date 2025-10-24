{ config, pkgs, ... }:

{
  # Disable root account
  users.users.root.hashedPassword = "!";

  # Define main user account
  users.users.michal = {
    isNormalUser = true;
    description = "Michal";
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "nixos";
  };

  # Enable sudo for wheel group
  security.sudo.wheelNeedsPassword = false;

  # Fix shutdown delay caused by user sessions
  # Reduce timeout for stopping user sessions during shutdown
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  # Configure user session manager to stop more quickly
  systemd.user.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  # Kill user processes on logout to prevent lingering sessions
  services.logind.killUserProcesses = true;
}