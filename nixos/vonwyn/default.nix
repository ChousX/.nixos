{...}:
{
  networking.hostName = "Vonwyn";

  imports = [
    ../base.nix
    ./hardware-configuration.nix
    ./boot.nix
    ./nvidia.nix
    ../kde.nix
    ../steam.nix
  ];
}
