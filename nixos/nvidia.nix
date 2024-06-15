{config, lib, pkgs, ...}:
{
  # Enable OpenGl
  hardware.opengl = {
    enable = true;
    driSupport = true;
    dirSupport32Bit = true;
  };

  # loading nvidia drivers for graphics server
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modestting.enable = true;
    powerManagement.enable = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
