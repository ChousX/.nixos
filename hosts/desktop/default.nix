{lib, inputs, outputs, ...}: {
  imports = [
    ../modules # = m
    ../../users/chousx.nix
    ./hardware-configuration.nix
    ./boot.nix
    ./nvidia.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  m = {
    basic_system.enable = true;
    bluetooth.enable = true;
    shell.zsh.enable = true;
    kdePlasma6.enable = true;
    sddm.enable = true;
    sound.enable = true;
    default_font_dyslexic.enable = true;
    steam.enable = true;
    localization.USA_ME.enable = true;
    stylix.enable = true;
    virt-manager.enable = true;
  };

  networking.hostName = "base-camp";
}
