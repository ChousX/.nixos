{config, lib, ...}: with lib; {
  options.m.shell.zsh.enable = mkEnableOption "enables/configurs zsh to my liking";
  config = mkIf config.m.shell.zsh.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion = {
        enable = true;
      };
      autocd = true;
      #syntaxHightlighting.enable = true;
      shellAliases = {
        v = ''nix run "github:ChousX/nix-neovim"'';
        ip = "ip --=color=auto";
      };
    };
  };
}
