{lib, config, pkgs, ...}: with lib;{
  options.m.waybar.enable = mkEnableOption "waybar";
  config = mkIf config.m.waybar.enable {
    home = {
      packages = with pkgs; [
        waybar
      ];
      file = {
        ".config/waybar".source = ../config/waybar;      };
    };
  };
}
