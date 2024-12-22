{pkgs, lib, config, ...}: with lib; {
  options.m.default_font_dyslexic.enable = mkEnableOption "enables OpenDyslexic as the default font";
  config = mkIf config.m.default_font_dyslexic.enable {
    fonts = {
      enableDefaultPackages = true;
      fontDir.enable = true;
      packages = with pkgs; [
        nerd-fonts._0xproto
      	nerd-fonts.open-dyslexic
      ];
      fontconfig = {
      	enable = true;
      	defaultFonts = {
          monospace = ["0xProto Nerd Font Mono"];
          sansSerif = ["OpenDyslexic Nerd Font"];
          serif = ["OpenDyslexic Nerd Font"];
	      };
      };
    };
  };
}
