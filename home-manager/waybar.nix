{pkgs, ...}: {

  home.file = {
    ".config/waybar".source = ./configs/waybar;
  };

  home.packages = with pkgs; [
    playerctl    
    pavucontrol
  ];

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = {
      sorce
    };
  };
}
