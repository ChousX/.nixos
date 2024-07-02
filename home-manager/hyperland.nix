{...}: {
  # Hyprland Config
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    bind = [
      "$mod, E, exec, emacs"
      "$mod, R, exec, rofi -show run"
      "$mod, F, exec, firefox"
      "$mod, Return, exec, alacritty"
      "$mod SHIFT, Q, killactive"
      "$mod SHIFT, Delete, exec, hyprctl dispatch exit"
      "$mod, A, exec, alacritty"
      #", Print, exec, "
    ] ++
    (
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
}
