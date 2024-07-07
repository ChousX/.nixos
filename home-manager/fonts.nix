{pkgs, ...} : {
<<<<<<< HEAD
  #fonts.fontconfig.enable = true;

  #home.packages = with pkgs; [
    nerdfonts
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
=======
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
>>>>>>> 7198ec4f1303203930699689a0ca2afa457dc285
}
        
