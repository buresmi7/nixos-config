{ config, pkgs, ... }:

{
  # System-wide applications
  environment.systemPackages = with pkgs; [
    git
    firefox
  ];

  # Git configuration
  programs.git = {
    enable = true;
    config = {
      user = {
        name = "Michal";
      };
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = false;
      };
    };
  };
}