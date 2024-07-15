{inputs, pkgs, ...}: {

  imports = [
    ./sddm.nix
  ];

  programs.hyprland = {
    enable = true;
  };

  home.packages = [
    pkgs.vesktop
  ];

  programs.waybar.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
