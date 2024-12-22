{pkgs, config, lib, ...}: with lib;{
  options.m.stylix.enable = mkEnableOption "enables stylix: a package that rices your system";
  config = mkIf config.m.stylix.enable {

    stylix = {
      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
      };
      fonts = {
        sizes = {
          applications = 12;
          terminal = 12;
          desktop = 10;
          popups = 10;
        };
        monospace = {
          package = pkgs.nerd-fonts.open-dyslexic;
          name = "OpenDyslexicM Nerd Font Mono";
        };
        sansSerif = {
          package= pkgs.nerd-fonts.open-dyslexic;
          name = "OpenDyslexic Nerd Font";
        };
        serif = {
          package= pkgs.nerd-fonts.open-dyslexic;
          name = "OpenDyslexic Nerd Font";
        };
      };
      opacity = {
        applications = 1.0;
        terminal = 0.9;
        desktop = 1.0;
        popups = 0.95;
      };
    };
  };
}
