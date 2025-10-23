{
  description = "NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, disko, ... }@inputs: {
    nixosConfigurations = {
      # VirtualBox test configuration
      vbox = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          # Disko for disk management
          disko.nixosModules.disko
          ./hosts/vbox/disko.nix
          
          # Modular configuration
          ./modules/boot.nix
          ./modules/networking.nix
          ./modules/locale.nix
          ./modules/desktop.nix
          ./modules/sound.nix
          ./modules/users.nix
          ./modules/apps.nix
          
          # Host-specific configuration
          ./hosts/vbox/host.nix
          
          # Home Manager
          home-manager.nixosModules.home-manager
          {
            home-manager.users.michal = import ./modules/home-manager.nix;
          }
        ];
      };

      # T480 laptop configuration
      t480 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          # Disko for disk management
          disko.nixosModules.disko
          ./hosts/t480/disko.nix
          
          # Modular configuration
          ./modules/boot.nix
          ./modules/networking.nix
          ./modules/locale.nix
          ./modules/desktop.nix
          ./modules/sound.nix
          ./modules/users.nix
          ./modules/apps.nix
          
          # Host-specific configuration
          ./hosts/t480/host.nix
          
          # Home Manager
          home-manager.nixosModules.home-manager
          {
            home-manager.users.michal = import ./modules/home-manager.nix;
          }
        ];
      };
    };
  };
}