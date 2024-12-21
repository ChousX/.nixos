{lib, config, ...}: with lib;{
  options.m.firefox.enable = mkEnableOption "";
  config = mkIf config.m.firefox.enable {
    programs.firefox.enable = true;
    home.sessionVariables.MOZ_ENABLE_WAYLAND = 0;
  };
}
