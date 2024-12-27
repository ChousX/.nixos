{lib, config, pkgs, ...}: with lib;{
  options.m.hyprpaper.enable = mkEnableOption "";
  config = mkIf config.m.hyprpaper.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        preload = ["~/.config/wallpaper.jpg"];
        wallpaper = ["eDP-1, ~/.config/wallpaper.jpg"];
      };
    };
    #home.file.".config/hypr/hyprpaper.conf".source = ../config/hypr/hyprpaper.conf;
    home.file.".config/wallpaper.jpg".source = ../config/wallpaper/000.jpg;
  };
}
