# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../modules
  ];
  nixpkgs = {
    overlays = [
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "chousx";
    homeDirectory = "/home/chousx";
    stateVersion = "24.05";
    packages = with pkgs; [
      bat
      ranger
      ripgrep
      starship
      dust
      tldr
      neovim
      nerd-fonts.open-dyslexic
    ];
  };
  systemd.user.startServices = "sd-switch";
  m = {
    git.enable = true;
    shell.zsh.enable = true;
  };
}
