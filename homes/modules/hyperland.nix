{lib, config, pkgs, ...}: with lib;{
  options.m.hyperland.enable = mkEnableOption "Does Nothing as of now :p";
  config = mkIf config.m.hyperland.enable {
      wayland.windowManager.hyprland = {
        plugins = [
          inputs.hyprgrass.packages.${pkgs.system}.default
        ];
        enable = true; # enable Hyprland
        settings = {
          "$mod" = "SUPER";
          bind = [
            "$mod, Enter, exec, firefox"
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
