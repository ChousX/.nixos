{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    packages = with pkgs; [ 
      (nerdfonts.override { fonts = [ "OpenDyslexic" ]; })
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["OpenDyslexicM Nerd Font Mono"];
        sansSerif = ["OpenDyslexic Nerd Font"];
        serif = ["OpenDyslexic Nerd Font"];
      };
    };
  };
}
