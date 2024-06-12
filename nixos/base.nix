{...}:
{
  xdg.portal.enable = true;
  services = {
    printing.enable = true;
    flatpak.enable = true;
  };
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.11";
}
