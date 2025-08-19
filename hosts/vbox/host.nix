{ config, pkgs, ... }:

{
  # Hostname
  networking.hostName = "nixos-vbox";

  # Enable VirtualBox guest additions
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.x11 = true;

  # Enable automatic login for the test user
  services.displayManager.autoLogin = {
    enable = true;
    user = "michal";
  };

  # VirtualBox specific packages
  environment.systemPackages = with pkgs; [
    # VirtualBox guest additions are handled by the module above
  ];

  # Allow unfree packages (for VirtualBox guest additions if needed)
  nixpkgs.config.allowUnfree = true;
}