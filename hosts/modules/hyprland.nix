{config, lib, pkgs, ...}: with lib; {
  options.m.hyprland.enable = mkEnableOption "enables hyprland a window manager";
  config = mkIf config.m.hyprland.enable {
      programs.hyprland = {
        enable = true;
        #TODO: if nvidia 
        nvidiaPatches = true;
        xwayland.enable = true;
      };
      xdg.portal.extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
      # Optional, hint Electron apps to use Wayland:
      environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
