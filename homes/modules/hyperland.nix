{lib, config, ...}: with lib;{
  options.m.hyperland.enable = mkEnableOption "Does Nothing as of now :p";
  config = mkIf config.m.hyperland.enable {
    
  };
}
