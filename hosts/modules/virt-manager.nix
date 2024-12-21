{pkgs, config, lib, ...}: with lib;{
  options.m.virt-manager.enable = mkEnableOption "enables vm's through virt-manager";
  config = mkIf config.m.virt-manager.enable {
    virtualisation = {
      libvirtd = {
        enable = true;
        #qemu = {
          #runAsRoot = true;
          #swtpm.enable = true;
          #ovmf = {
            #enable = true;
            #pkackages = [(pkgs.OVMF.override {
              #secureBoot = true;
              #tmpSupport = true;
            #}).fd];
          #};
      };
      spiceUSBRedirection.enable = true;
    };
    programs.virt-manager.enable = true;
  };
}
