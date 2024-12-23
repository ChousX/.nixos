{lib, config, pkgs, ...}: with lib;{
  options.m.hyprpaper.enable = mkEnableOption "";
  config = mkIf config.m.hyprpaper.enable {
    file.".config/hypr/hyprpaper.conf".source = ../config/hypr/hyprpaper.conf;
    file.".config/wallpaper.jpg".source = ../config/wallpaper/000.jpg;
  };
}
