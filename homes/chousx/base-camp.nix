{pkgs, ...}: {
  imports = [./home.nix];
  home.packages = with pkgs; [
    firefox-wayland
    terminator
    discord
  ];
  m = {
    terminal.alacritty.enable  = true;
    terminal.kitty.enable  = true;
  };
}
