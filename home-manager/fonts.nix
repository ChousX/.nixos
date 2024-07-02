{pkgs, ...} : {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
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
    roboto
    helvetica-neue-lt-std
  ];
}
        
