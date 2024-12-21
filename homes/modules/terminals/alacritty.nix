{pkgs, lib, config, ...}: with lib; {
  options.m.terminal.alacritty.enable = mkEnableOption "enables/configurs alacritty: terminal emulator";
  config = mkIf config.m.terminal.alacritty.enable {
    home = {
      packages = with pkgs; [
        alacritty
        nerd-fonts.open-dyslexic
      ];
      file = {
        ".config/alacritty".source = ../../config/alacritty;
      };
    };
  };
}
