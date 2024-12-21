{config, lib, ...}: with lib; {
  options.m.sound.enable = mkEnableOption "enables pipewire for sound";
  config = mkIf config.m.sound.enable {
    hardware.pulseaudio = {
      enable = false;
      package = pkgs.pulseaudioFull;
    };
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
