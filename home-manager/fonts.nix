{pkgs, ...} : {
  #fonts.fontconfig.enable = true;

  #home.packages = with pkgs; [
    #nerdfonts
    #noto-fonts
    #noto-fonts-cjk
    #noto-fonts-emoji
    #liberation_ttf
    #fira-code
    #fira-code-symbols
    #mplus-outline-fonts.githubRelease
    #dina-font
    #proggyfonts
  #];
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
    open-dyslexic
    helvetica-neue-lt-std
  ];
}
        
