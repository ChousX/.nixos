{pkgs, lib, config, ...}: with lib; {
  options.m.terminal.kitty.enable = mkEnableOption "enables/configurs alkitty: terminal emulator";
  config = mkIf config.m.terminal.kitty.enable {
    programs.kitty = {
      enable = true;
      settings = {
        dynamic_background_opacity = true;
        enable_audio_bell = false;
        background_opacity = "0.8";
      };
    };
  };
}
