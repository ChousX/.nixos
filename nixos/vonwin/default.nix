{...}:
{
  networking.hostName = "Vonwyn";

  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./nvidia.nix
    ./steam.nix
  ];
}
