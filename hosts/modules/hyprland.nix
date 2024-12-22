{inputs, config, lib, pkgs, ...}: with lib; {
  options.m.hyprland.enable = mkEnableOption "enables hyprland a window manager";
  config = mkIf config.m.hyprland.enable {
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      };
      xdg.portal.extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
      # Optional, hint Electron apps to use Wayland:
      environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
