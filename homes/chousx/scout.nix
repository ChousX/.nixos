{pkgs, ...}: {
  imports = [./home.nix];
  home.packages = with pkgs; [
    firefox-wayland
    terminator
    discord
    ranger
  ];
  m = {
    terminal.alacritty.enable  = true;
    hyprland_config.enable  = true;
    hyprpaper.enable = true;
    waybar.enable = true;
  };
}
