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
}