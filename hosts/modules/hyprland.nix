{config, lib, ...}: with lib; {
  options.m.hyprland.enable = mkEnableOption "enables hyprland a window manager";
  config = mkIf config.m.hyprland.enable {
      programs.hyprland.enable = true; # enable Hyprland
      
      # Optional, hint Electron apps to use Wayland:
      environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
