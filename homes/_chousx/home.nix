{inputs, lib, config, pkgs, ...}: 
{
  #overlays = [];
  config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };
  home = {
    username = lib.mkDefault "chousx";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = "24.05"; # Please read the comment before changing.

    packages = with pkgs; [
      bat
      ranger
      ripgrep
      starship
      dust
      tldr
      git
      nvim

      (nerdfonts.override { fonts = ["OpenDyslexic"];})
  
      alacritty
      terminator
      firefox
    ];

    file = {
      ".config/alacritty".source = ./config/alacritty;
    };

    sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
