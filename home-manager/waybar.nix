{pkgs, ...}: {
  home.packages = with pkgs; [
    playerctl    
    pavucontrol
  ];

  programs.waybar = {
    enable = true;
    systemd.enable = true;
  }
}
