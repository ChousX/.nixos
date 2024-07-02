{pkgs, ...} : {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    arial
    sans-serif
    font-awesome
    fira-code
    fira-code-symbols
    font-awesome
    liberation_ttf
    mplus-outline-fonts.githubRelease
    nerdfonts
    noto-fonts
    noto-fonts-emoji
    proggyfonts

  ];
}
        
