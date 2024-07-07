{...}:
{
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      device = "/dev/nvme0n1";
      useOSProber = true;
    };
  };
}
