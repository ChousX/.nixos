{lib, config, ...}: with lib; {
  options.m.bluetooth.enable = mkEnableOption "enables bluetooth";
  config = mkIf config.m.bluetooth.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General.Experimental = true;
    };
    services.blueman.enable = true;
  };
}
