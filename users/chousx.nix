{
  config,
  pkgs,
  inputs,
  ...
}: {
  users.users.chousx = {
    initialHashedPassword = "$y$j9T$kCvBYJduwfMcps6i2wWdE0$RCDpQmxNIZRroRWSYxmQ8nbYYqRCW6ANtnLMRjiWpe3";
    isNormalUser = true;
    description = "A. Garrett Gelwick III";
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
      "flatpak"
      "audio"
      "video"
      "plugdev"
      "input"
      "kvm"
      "qemu-libvirtd"
    ];
    openssh.authorizedKeys.keys = [
    ];
    packages = [inputs.home-manager.packages.${pkgs.system}.default];
  };
  home-manager.users.chousx = import ../homes/chousx/${config.networking.hostName}.nix;
}

