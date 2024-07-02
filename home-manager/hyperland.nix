{pkgs, ...}: {
  xdg.portal = {
    extraPortals = [ pkgs.inputs.hyprland.xdg-desktop-portal-hyprland ];
    configPackages = [ pkgs.inputs.hyprland.hyprland ];
  };


  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      "monitor" = ",preferred,auto,auto";
      "$mod" = "SUPER";
      "$term" = "alacritty";

      bind = [
        "$mod, Return, exec, $term"
        "$mod SHIFT, Q, killactive"
        "$mod, F, exec, firefox"
      ] ++ (
        builtins.concatLists (builtins.genList (
          x: let
            ws = let
                c = (x + 1) / 10;
            in
                builtins.toString (x + 1 - (c * 10));
          in [
            "$mod, ${ws}, workspace, ${toString (x + 1)}"
            "$mod SHIFT, ${ws}, movetoworkspace, ${toString(x + 1)}"
            ]
          )
          10
        )
      );
    };
  };
}