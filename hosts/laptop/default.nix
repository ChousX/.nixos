{lib, inputs, outputs, ...}: {
  imports = [
    ../modules # = m
    ./boot.nix
    ./hardware-configuration.nix
    ../../users/chousx.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  m = {
    basic_system.enable = true;
    bluetooth.enable = true;
    default_font_dyslexic.enable = true;
    flatpak.enable = true;
    hyprland.enable = true;
    localization.USA_ME.enable = true;
    shell.zsh.enable = true;
    sound.enable = true;
    sddm.enable = true;
  };

  networking.hostName = "scout";
}
