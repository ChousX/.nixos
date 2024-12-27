{lib, config, pkgs, inputs, ...}: 
with lib;{
  options.m.hyprland_config.enable = mkEnableOption "Does Nothing as of now :p";
  config = mkIf config.m.hyprland_config.enable {
    home.packages = with pkgs;[
      rofi-wayland
      brightnessctl
      wireplumber
      wl-clipboard
      swappy
      grim
      slurp
      imagemagick
      kitty
      firefox-wayland
      networkmanagerapplet
    ];
    wayland.windowManager.hyprland = let 
      pypr = pkgs.pyprland + "/bin/pypr";
    in {
      plugins = [
        inputs.hyprgrass.packages.${pkgs.system}.default
      ];
      enable = true; # enable Hyprland
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      extraConfig = 
      let
	      nm-connection-editor = pkgs.networkmanagerapplet + "/bin/nm-connection-editor";
        waybar = pkgs.waybar + "/bin/waybar";
        hyprpaper = pkgs.hyprpaper + "/bin/hyprpaper";
      in ''
        general {
            gaps_in = 1
            gaps_out = 2
            border_size = 1
        }

        xwayland {
            force_zero_scaling = true
        }

        plugin {
          touch_gestures {
            sensitivity = 4.0

            # must be >= 3
            workspace_swipe_fingers = 3
          }
        }

        gestures {
          workspace_swipe = true
          workspace_swipe_cancel_ratio = 0.15
        }

        exec-once = ${waybar}
        exec-once = ${hyprpaper}
        exec-once = ${pypr}

        # Cursor size in qt applications
        env = XCURSOR_SIZE, 18

        input {
            follow_mouse = 1

            touchpad {
                natural_scroll = no
            }

            # -1.0 - 1.0, 0 means no modification.
            sensitivity = 0 
            repeat_delay = 200
            repeat_rate = 40
        }

        decoration {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          blur {
            enabled = yes
            size = 3
            passes = 1
          }
            rounding = 7
        }

        animations {
          enabled = yes
          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
          bezier = myBezier, 0.05, 0.9, 0.1, 1.05
          animation = windows, 1, 4, myBezier
          animation = windowsOut, 1, 4, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 4, default
          animation = fade, 1, 4, default
          animation = workspaces, 1, 4, default
        }

        dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = yes # you probably want this
        }

        gestures {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more
            workspace_swipe = on
        }

        misc {
          disable_hyprland_logo = true
        }

        $scratchpadsize = size 80% 85%
        $scratchpad = class:^(scratchpad)$
        windowrulev2 = float,$scratchpad
        windowrulev2 = $scratchpadsize,$scratchpad
        windowrulev2 = workspace special silent,$scratchpad
        windowrulev2 = center,$scratchpad

        $pavucontrol = class:^(pavucontrol)$
        windowrulev2 = float,$pavucontrol
        windowrulev2 = size 86% 40%,$pavucontrol
        windowrulev2 = move 50% 6%,$pavucontrol
        windowrulev2 = workspace special silent,$pavucontrol
      '';
      settings =
      let 
	      rofi = pkgs.rofi-wayland +"/bin/rofi";
	      grim = pkgs.grim + "/bin/grim";
        slurp = pkgs.slurp + "/bin/slurp";
        swappy = pkgs.swappy + "/bin/swappy";

	      brightnessctl = pkgs.brightnessctl + "/bin/brightnessctl";
	      convert = pkgs.imagemagick + "/bin/convert";
    	  wpctl = pkgs.wireplumber + "/bin/wpctl";
	      terminal = pkgs.alacritty + "/bin/alacritty";
	      browser = pkgs.firefox-wayland + "/bin/firefox";
	      launcher = "${rofi} -show drun";
    	  paste = pkgs.wl-clipboard + "/bin/wl-paste";
      in {
        "$mod" = "SUPER";
        bind = [
	        "$mod, RETURN, exec, ${terminal}"
          "$mod, B, exec, ${browser}"
          #Launcher
          "$mod, P, exec, ${launcher}"
          "$mod, D, exec, ${launcher}"

          #Screan Shot
          ''$mod SHIFT, S, exec, ${grim} -g "$(${slurp})" - | ${convert} - -shave 3x3 PNG:- | ${swappy} -f -''
          "$mod SHIFT, E, exec, ${paste} | ${swappy} -f -"

          #LogOut
          "$mod SHIFT, DELETE, exit"

          #Kill
          "$mod SHIFT, Q, killactive"
          ", swipe:4:d, killactive"

           # Move focus with mainMod + arrow keys
          "$mod, h, movefocus, l"
          "$mod, l, movefocus, r"
          "$mod, k, movefocus, u"
          "$mod, j, movefocus, d"

	        #Brightness
          ",XF86MonBrightnessUp, exec, ${brightnessctl} set +4%"
          ",XF86MonBrightnessDown, exec, ${brightnessctl} set 4%-"
          "SHIFT, XF86MonBrightnessUp, exec, ${brightnessctl} set 100%"
          "SHIFT, XF86MonBrightnessDown, exec, ${brightnessctl} set 10%"

          #Volume
          ",XF86AudioRaiseVolume, exec, ${wpctl} set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 4%+"
          ",XF86AudioLowerVolume, exec, ${wpctl} set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 4%-"
          "SHIFT, XF86AudioRaiseVolume, exec, ${wpctl} set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 100%"
          "SHIFT, XF86AudioLowerVolume, exec, ${wpctl} set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 10%"
          ",XF86AudioMute, exec, ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle"

          # Scratchpads
          "$mod,T,exec,${pypr} toggle term && hyprctl dispatch bringactivetotopA"
          "$mod,C,exec,${pypr} toggle calculator && hyprctl dispatch bringactivetotop"
          "$mod,A,exec,${pypr} toggle pavucontrol && hyprctl dispatch bringactivetotop"

          # Scroll through existing workspaces with mainMod + scroll
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"

        ] ++ (builtins.concatLists (builtins.genList (i: let ws = i + 1; in [
          "$mod, code:1${toString i}, workspace, ${toString ws}"
          "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
        ])9));
      };
    };
  };
}
