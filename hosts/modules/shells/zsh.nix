{config, lib, pkgs, ...}: with lib; {
  options.m.shell.zsh.enable = mkEnableOption "enables zsh and sets it as deafualt";
  config = mkIf config.m.shell.zsh.enable {
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;
  };
}
