{inputs, outputs, lib, config, pkgs, ...}:
{
  networking.hostName = "Oric";

  imports = [
    ../.
    ./hardware-configuration.nix
    ./boot.nix
    ../hyprland.nix
  ];

}
