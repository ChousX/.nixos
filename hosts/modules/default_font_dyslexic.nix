{pkgs, lib, config, ...}: with lib; {
  options.m.default_font_dyslexic.enable = mkEnableOption "enables OpenDyslexic as the default font";
  config = mkIf config.m.default_font_dyslexic.enable {
    fonts = {
      enableDefaultPackages = true;
      fontDir.enable = true;
      packages = with pkgs; [
      	nerd-fonts.open-dyslexic
      ];
      fontconfig = {
      	enable = true;
      	defaultFonts = {
          monospace = ["OpenDyslexicM Nerd Font Mono"];
          sansSerif = ["OpenDyslexicM Nerd Font"];
          serif = ["OpenDyslexicM Nerd Font"];
	      };
      };
    };
  };
}
