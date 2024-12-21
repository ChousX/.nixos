{pkgs, config, lib, ...}: with lib; {
  options.m.steam.enable = mkEnableOption "enables steam the game service";
  config = mkIf config.m.steam.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    programs.gamemode.enable = true;
    hardware.graphics.enable = true;
  };
}
