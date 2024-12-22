{lib, config, pkgs, inputs, ...}: 

with lib;{
  options.m.hyprland.enable = mkEnableOption "Does Nothing as of now :p";
  config = mkIf config.m.hyprland.enable {
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
      settings = 
      let 
        grim = pkgs.grim + "/bin/grim";
        slurp = pkgs.slurp + "/bin/slurp";
        rofi = pkgs.rofi-wayland + "/bin/rofi";
        launcher = "${rofi} -show drun";
        terminal = pkgs.alacritty + "/bin/alacritty";
        brightnessctl = pkgs.brightnessctl + "/bin/brightnessctl";
        wpctl = pkgs.wireplumber + "/bin/wpctl";
        paste = pkgs.wl-clipboard + "/bin/wl-paste";
        swappy = pkgs.swappy + "/bin/swappy";
        convert = pkgs.imagemagick + "/bin/convert";
      in
      {
        "$mod" = "SUPER";
        bind = [
          "$mod, D, exec, ${launcher}"
          "$mod, P, exec, ${launcher}"
          "$mod SHIFT, Enter, exec, ${terminal}"
          "$mod SHIFT, Q, killactive"
          # Move focus with mainMod + arrow keys
          "$mod, h, movefocus, l"
          "$mod, l, movefocus, r"
          "$mod, k, movefocus, u"
          "$mod, j, movefocus, d"
          # Volume and Brightness
          ",XF86MonBrightnessUp, exec, ${brightnessctl} set +4%"
          ",XF86MonBrightnessDown, exec, ${brightnessctl} set 4%-"
          "SHIFT, XF86MonBrightnessUp, exec, ${brightnessctl} set 100%"
          "SHIFT, XF86MonBrightnessDown, exec, ${brightnessctl} set 10%"
          ",XF86AudioRaiseVolume, exec, ${wpctl} set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, ${wpctl} set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
          "SHIFT, XF86AudioRaiseVolume, exec, ${wpctl} set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 100%"
          "SHIFT, XF86AudioLowerVolume, exec, ${wpctl} set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 10%"
          ",XF86AudioMute, exec, ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle"

          ''$mod SHIFT, S, exec, ${grim} -g "$(${slurp})" - | ${convert} - -shave 3x3 PNG:- | ${swappy} -f -''
          "$mod SHIFT, E, exec, ${paste} | ${swappy} -f -"
        ] ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
        9)
      );};
    };
  };
}
