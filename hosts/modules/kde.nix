{pkgs, config, lib, ...}: with lib; {
  options.m.kdePlasma6.enable = mkEnableOption "enable KDE Plasma 6 (Wayland)"; 
  config = mkIf config.m.kdePlasma6.enable {
    services = {
      desktopManager.plasma6.enable = true;
      xserver.enable = true;
    };
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      plasma-browser-integration
      konsole
      oxygen
    ];
    programs.kdeconnect.enable = true;
  };
}
