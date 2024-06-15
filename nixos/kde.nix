{pkgs, ...}:
{
services.xserver.desktopManager.plasma5.enable = true;
# KDE Plasma 6 is now available on unstable
#services.desktopManager.plasma6.enable = true;

#environment.plasma6.excludePackages = with pkgs.kdePackages; [
  #plasma-browser-integration
  #konsole
  #oxygen
#];

environment.systemPackages = with pkgs.kdePackages; [
  audiotube
];

programs.kdeconnect = { 
  enable = true;
   
};


}
