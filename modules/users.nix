{ config, pkgs, ... }:

{
  # Define main user account
  users.users.michal = {
    isNormalUser = true;
    description = "Michal";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Enable sudo for wheel group
  security.sudo.wheelNeedsPassword = false;
}