{lib, config, pkgs, ...}: with lib;{
  options.m.rofi.enable = mkEnableOption "";
  config = mkIf config.m.rofi.enable {
    programs.rofi= {
      enable = true;
      package = pkgs.rofi-wayland;
      location = "center";
      cycle = true;
      plugins = with pkgs; [
        rofi-calc
        rofi-emoji
        rofi-systemd
      ];
    };
  };
}
