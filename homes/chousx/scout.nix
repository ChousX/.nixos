{pkgs, ...}: {
  imports = [./home.nix];
  home.packages = with pkgs; [
    firefox
    terminator
    discord
    ranger
  ];
  m = {
    terminal.alacritty.enable  = true;
  };
}
