# This file needs to be generated on your T480 laptop.
#
# To generate this file:
# 1. Boot from NixOS installer on your T480
# 2. Run: nixos-generate-config --show-hardware-config > hardware-configuration.nix
# 3. Replace this file with the generated content
#
# Below is a template - REPLACE WITH ACTUAL GENERATED CONFIG

{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  # These will be detected automatically - REPLACE WITH ACTUAL VALUES
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # Example disk configuration - REPLACE WITH ACTUAL VALUES
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/REPLACE-WITH-ACTUAL-ROOT-UUID";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/REPLACE-WITH-ACTUAL-BOOT-UUID";
      fsType = "vfat";
    };

  swapDevices = 
    [ { device = "/dev/disk/by-uuid/REPLACE-WITH-ACTUAL-SWAP-UUID"; }
    ];

  # Enables DHCP on each ethernet and wireless interface
  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # T480 specific hardware
  # Intel graphics
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}