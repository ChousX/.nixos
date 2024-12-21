{pkgs, ...}: {
  imports = [./home.nix];
  home.packages = with pkgs; [
    firefox
    terminator
    discord
    path-of-building
  ];
  m = {
    terminal.alacritty.enable  = true;
    terminal.kitty.enable  = true;
  };
}
