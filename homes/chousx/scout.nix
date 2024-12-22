{pkgs, ...}: {
  imports = [./home.nix];
  home.packages = with pkgs; [
    firefox
    terminator
    discord
  ];
  m = {
    terminal.alacritty.enable  = true;
  };
}
