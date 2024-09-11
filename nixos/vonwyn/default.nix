{...}:
{
  networking.hostName = "Vonwyn";

  imports = [
    ../.
    ./hardware-configuration.nix
    ./boot.nix
    ./nvidia.nix
    ../kde.nix
    ../steam.nix
  ];
}
