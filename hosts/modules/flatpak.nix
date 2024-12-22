{config, lib, ...}: with lib; {
  options.m.flatpak.enable = mkEnableOption "enables flatpak's";
  config = mkIf config.m.flatpak.enable {
    services.flatpak.enable = true;
    xdg.portal.enable = true;
  };
}
