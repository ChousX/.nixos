{inputs, pkgs, ...}: {

  imports = [
    ./sddm.nix
  ];

  programs.hyprland = {
    enable = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    # --Utility to manage outputs of a Wayland compositor (aka xrandr but wayland)--
    wlr-randr
    brightnessctl
    # --A simple notification daemon with a GTK gui --
    swaynotificationcenter
    # --pulseaudio command line mixer--
    pamixer
    networkmanagerapplet
    playerctl
    # --Compositor--
    swww
    # --Screenshots--
    grim
    slurp

    # --Overlays Bars and more--
    waybar
    wlogout
    # --Application Grid--
    nwg-drawer
  ];
}
