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
  };
}
