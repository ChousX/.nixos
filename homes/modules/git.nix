{lib, config, ...}: with lib; {
  options.m.git = {
    enable = mkEnableOption "enables/configurs git";
  };
  config = mkIf config.m.git.enable {
    programs.git = {
      enable = true;
      userName = "ChousX";
      userEmail = "gmanenergy@gmail.com";
      aliases = {
        pu = "push";
        co = "chechout";
        br = "branch";
        cm = "commit -a -m";
      };
    };
  };
}
