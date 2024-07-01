{pkgs, ...}:
{
  networking.hostName = "Vonwyn";

  imports = [
    ./steam.nix
  ];
}
