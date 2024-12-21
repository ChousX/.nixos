{lib, config, ...}: with lib; {
  options.m.sddm.enable = mkEnableOption "enables sddm";
  config = mkIf config.m.sddm.enable {
    services = {
      xserver.enable = true;
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
  };
}
