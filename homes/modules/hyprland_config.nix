{lib, config, pkgs, inputs, ...}: 
with lib;{
  options.m.hyprland_config.enable = mkEnableOption "Does Nothing as of now :p";
  config = mkIf config.m.hyprland_config.enable {
    home.packages = with pkgs;[
      rofi-wayland
      brightnessctl
      wireplumber
      rofi-wayland
      wl-clipboard
      swappy
      grim
      slurp
      imagemagick
      kitty
    ];
    wayland.windowManager.hyprland = {
      plugins = [
        inputs.hyprgrass.packages.${pkgs.system}.default
      ];
      enable = true; # enable Hyprland
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      settings = {
        "$mod" = "SUPER";
	"$terminal" =  pkgs.kitty;
        bind = [
	  ''$mod, ENTEER, exec, ${pkgs.kitty + "bin/kitty"}''
          "$mod SHIFT, ENTER, exec, $terminal"
          "$mod SHIFT, F, exec, firefox"
          "$mod SHIFT, DELETE, exec,  exit"
        ];
      };
    };
  };
}
