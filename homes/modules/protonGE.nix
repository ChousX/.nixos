{lib, config, pkgs, ...}: with lib;{
  options.m.protonGE.enable = mkEnableOption "settes up protonup for installing protonGE";
  config = mkIf config.m.protonGE.enable {
    home = {
      packages = with pkgs; [
        protonup
      ];
      sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibitytools.d";
      };
    };
  };
}
