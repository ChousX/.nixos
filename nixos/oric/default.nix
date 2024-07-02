{inputs, outputs, lib, config, pkgs, ...}:
{
  networking.hostName = "Oric";

  imports = [
    ../base.nix
    ./hardware-configuration.nix
    ./boot.nix
    #../kde.nix
    ../hyprland.nix
  ];

}
